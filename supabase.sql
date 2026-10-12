-- Jalankan di Supabase SQL Editor.
-- Hanya data agregat per cabang/tanggal yang dipublikasikan; tidak ada data nama/nomor HP.
create table if not exists public.report_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
create table if not exists public.published_reports (
  id integer primary key check (id = 1),
  payload jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id)
);
alter table public.report_admins enable row level security;
alter table public.published_reports enable row level security;
create or replace function public.is_report_admin() returns boolean language sql stable security definer set search_path = '' as $$
 select exists (select 1 from public.report_admins where user_id = (select auth.uid()));
$$;
revoke all on function public.is_report_admin() from public;
grant execute on function public.is_report_admin() to authenticated;

-- Viewer dapat membaca data agregat; tidak dapat menulis.
create policy "Public read published reports" on public.published_reports
  for select to anon, authenticated using (true);
create policy "Admin insert reports" on public.published_reports
  for insert to authenticated with check (public.is_report_admin());
create policy "Admin update reports" on public.published_reports
  for update to authenticated using (public.is_report_admin())
  with check (public.is_report_admin());

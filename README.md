# 📱 QuoteVault iOS App — Full Setup Guide


# 1️⃣ Clone the repository
<br>
git clone https://github.com/your-username/QuoteVault.git <br>
cd QuoteVault <br>
Open QuoteVault.xcodeproj in Xcode <br>


# 2️⃣ Create Supabase project
<br>
Visit: https://supabase.com <br>
Create a new project<br>
After setup, go to:<br>
Settings → API<br>
Copy:<br>
Project URL<br>
anon public key<br>


# 3️⃣ Add Supabase keys in the app <br>
Open file: <br>
Core/SupabaseManager.swift <br>
Replace with your keys: <br>

<br>

let client = SupabaseClient(
    supabaseURL: URL(string: "YOUR_PROJECT_URL")!,
    supabaseKey: "YOUR_ANON_PUBLIC_KEY"
)


# 4️⃣ Setup database (Supabase → SQL Editor)
<br>
---- quotes table (RLS policy) ---- <br>
<br>
create policy "Public read quotes" <br>
on public.quotes <br>
for select <br>
to public <br>
using ( true ); <br>

---quotes table columns:---<br>
<br>
id (int8, primary key, identity)<br>
content (text, not null)<br>
author (text, not null)<br>
category (text, not null)<br>

<br> 
---- favorites table (RLS policies) ----
<br>
create policy "Users can read own favorites" <br>
on public.favorites <br>
for select <br>
using ( auth.uid() = user_id ); <br>

<br>
create policy "Users can insert own favorites" <br>
on public.favorites <br>
for insert <br>
with check ( auth.uid() = user_id ); <br>

<br>
create policy "Users can delete own favorites" <br>
on public.favorites <br>
for delete <br>
using ( auth.uid() = user_id ); <br>

<br>

---favorites table columns:---<br>
id (int8, primary key, identity) <br>
user_id (uuid) <br>
quote_id (int8) <br>
content (text) <br>
author (text)<br>
category (text) <br>


# 5️⃣ Add some quotes (Supabase → quotes → Insert row) <br>
Example: <br>
content: Stay hungry, stay foolish. <br>
author: Steve Jobs <br>
category: Motivation <br>

# 6️⃣ Run the app <br>
Open project in Xcode <br>
Select any iPhone simulator <br>
Press ▶ Run <br>
Sign up / Login <br>
🎉 Quotes will load from Supabase <br>


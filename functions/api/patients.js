export async function onRequestGet(context) {
  const headers = {
    "Content-Type": "application/json",
    "Cache-Control": "no-store",
    "Access-Control-Allow-Origin": "*"
  };

  if (!context.env.DB) {
    return new Response(JSON.stringify({ ok: false, error: "D1 binding DB is not configured" }), { status: 503, headers });
  }

  const result = await context.env.DB.prepare(
    "SELECT id, patient_code, display_name, birth_year, created_at FROM patients ORDER BY created_at DESC"
  ).all();

  return new Response(JSON.stringify({ ok: true, demo_only: true, data: result.results || [] }), { headers });
}

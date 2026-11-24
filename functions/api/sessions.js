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
    "SELECT id, patient_id, assessment_key, status, started_at, submitted_at, created_at FROM assessment_sessions ORDER BY created_at DESC"
  ).all();

  return new Response(JSON.stringify({ ok: true, demo_only: true, data: result.results || [] }), { headers });
}

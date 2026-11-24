export async function onRequestGet() {
  return Response.json({
    ok: true,
    service: "mantapjiwa-api",
    mode: "prototype",
    data: "synthetic-only",
    timestamp: new Date().toISOString()
  }, {
    headers: { "Cache-Control": "no-store" }
  });
}

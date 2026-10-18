# Internet/WebRTC production plan

Media:
Guide iPhone
  -> WebRTC publisher
  -> SFU
  -> WebRTC subscribers (jamaah)

Signaling:
HTTPS + WebSocket

Infrastructure:
- SFU: LiveKit / mediasoup / Janus
- TURN: coturn
- TLS: HTTPS/WSS
- Session token: short-lived
- QR payload: session ID + signed join token

Fallback policy:
1. Discover local guide via Bonjour.
2. If local route is healthy, stay local.
3. If local route disappears, switch to internet session.
4. Reconnect with exponential backoff.
5. Return to local route when available and authenticated.

Security:
- Each session has a random ID.
- Join token expires.
- Only guide can publish.
- Jamaah is subscribe-only.
- Session can be closed by guide.

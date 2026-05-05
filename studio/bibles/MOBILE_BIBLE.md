# Mobile Bible — Shellmates

## Platform Target
- Android and iOS are first-class targets.
- Product is mobile-first, not desktop-ported.
- Portrait-first is the provisional layout recommendation until revised in decision log.

## Session Design Principles
- Support short sessions (2–10 minutes).
- Design for asynchronous use across the day.
- Assume uneven partner availability.
- Preserve context between interrupted sessions.

## UX and Interaction Standards
- Touch-first controls with generous tap targets.
- Safe-area compliance for notches and rounded corners.
- One primary action per screen where possible.
- Clear state for “my progress”, “partner progress”, and “shared gate status”.

## Readability Standards
- Text sizes must remain legible on small phones.
- Pixel art silhouettes must remain readable at phone scale.
- UI contrast must support diverse lighting conditions.

## Performance and Battery Principles
- Minimise idle background work.
- Keep frame pacing stable on mid-range devices.
- Optimise for low data/battery overhead.

## Accessibility Principles
- Support scalable text strategy.
- Ensure colour contrast and icon distinction.
- Avoid essential information conveyed by colour alone.
- Allow reduced motion where practical.

## Notification Principles (Planning Only)
- No implementation yet without approval.
- Any future reminder system must be opt-in and category-based.
- Never use guilt language (e.g., “your partner is waiting on you”).
- Prefer magical, neutral prompts if notifications are later approved.

## Real-Phone Validation (Later Milestones)
- Test portrait UI readability on small/large devices.
- Validate touch ergonomics one-handed.
- Validate battery/performance under short repeated sessions.
- Validate interruption recovery (lock screen/app switching).

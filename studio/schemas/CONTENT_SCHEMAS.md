# Content Schemas — Initial Data Guide

Schemas are required before content scaling. Content must be data-driven.
Large generated content packs are forbidden until schema, review, and QA are approved.

## 1) Story Chapter
- **Purpose:** Defines full asynchronous chapter package.
- **Required fields:** `chapter_id`, `title`, `theme`, `my_path_id`, `their_path_id`, `tidegate_id`, `resolution_id`, `reward_ids[]`.
- **Optional fields:** `intro_npc_id`, `support_action_ids[]`, `season_tag`.
- **Validation notes:** IDs must resolve; chapter must include both partner paths.
- **Safety notes:** No guilt/blame framing in chapter text metadata.
- **Example stub:** `{ "chapter_id": "ch_lantern_01", "theme": "noticing_each_other" }`

## 2) Player Path
- Purpose: Solo progression steps per partner.
- Required: `path_id`, `owner_role` (A/B), `step_ids[]`, `completion_signal`.
- Optional: `support_unlocks[]`.
- Validation: Minimum one step; no direct completion of shared gate alone.
- Safety: Must remain rewarding, non-punitive.
- Stub: `{ "path_id": "path_a_lantern", "owner_role": "A" }`

## 3) Tidegate
- Purpose: Shared gate requiring both partner contributions.
- Required: `tidegate_id`, `required_signals[]`, `unlock_text_key`.
- Optional: `fallback_hint_key`.
- Validation: Must reference both partner signal types.
- Safety: Avoid “waiting on partner” blame language.
- Stub: `{ "tidegate_id": "tg_lantern_half_light" }`

## 4) Prompt
- Purpose: Shell prompt entry.
- Required: `prompt_id`, `category`, `intensity`, `text_key`, `opt_in_level`.
- Optional: `swap_options[]`, `lighter_variant_id`, `save_for_later_allowed`.
- Validation: Brave prompts require explicit signposting.
- Safety: No diagnosis/therapy framing.
- Stub: `{ "prompt_id": "pr_warm_01", "category": "Warm Shells" }`

## 5) Shell Note
- Purpose: Lightweight asynchronous message object.
- Required: `note_id`, `sender_role`, `recipient_role`, `template_key`.
- Optional: `attachment_item_id`.
- Validation: Template must be approved tone-safe copy.
- Safety: No guilt pressure phrasing.
- Stub: `{ "note_id": "sn_001", "sender_role": "A" }`

## 6) Mood
- Purpose: Optional mood ritual state.
- Required: `mood_id`, `label_key`, `icon_key`.
- Optional: `ritual_suggestion_ids[]`.
- Validation: Labels remain non-clinical.
- Safety: No mental-health diagnosis semantics.
- Stub: `{ "mood_id": "m_calm" }`

## 7) Date Idea
- Purpose: Playful optional shared activity suggestion.
- Required: `date_id`, `title_key`, `duration_band`, `effort_band`.
- Optional: `indoors_outdoors_tag`, `cost_tag`.
- Validation: Must include “optional” framing.
- Safety: No judgement for skipped ideas.
- Stub: `{ "date_id": "d_starglass_walk" }`

## 8) Lobster Cosmetic
- Purpose: Companion appearance customisation item.
- Required: `cosmetic_id`, `slot`, `style_tags[]`, `unlock_source`.
- Optional: `season_tag`.
- Validation: Slot compatibility checks.
- Safety: No status/relationship-value implication.
- Stub: `{ "cosmetic_id": "lob_hat_shellcap" }`

## 9) Decoration
- Purpose: Placeable Cove décor item.
- Required: `decor_id`, `category`, `footprint`, `unlock_source`.
- Optional: `set_tag`, `interaction_type`.
- Validation: Placement rules must be explicit.
- Safety: Neutral to partner activity levels.
- Stub: `{ "decor_id": "cove_lantern_small" }`

## 10) Reward
- Purpose: Generic reward payload from actions/chapters.
- Required: `reward_id`, `type`, `quantity_or_ref`.
- Optional: `presentation_key`.
- Validation: Must map to known resource/item type.
- Safety: No reward text implying partner blame.
- Stub: `{ "reward_id": "rw_seaglass_20", "type": "SeaGlass" }`

## 11) Keepsake
- Purpose: Unique memory object from notable shared moments.
- Required: `keepsake_id`, `title_key`, `origin_chapter_id`.
- Optional: `display_variant_key`.
- Validation: Must tie to shared chapter outcome.
- Safety: Must celebrate connection, not performance ranking.
- Stub: `{ "keepsake_id": "ks_half_lit_lantern" }`

## 12) NPC
- Purpose: Narrative character metadata.
- Required: `npc_id`, `name_key`, `role_tag`, `tone_tags[]`.
- Optional: `home_location`.
- Validation: Tone tags must match narrative bible.
- Safety: Avoid judgemental authority voice.
- Stub: `{ "npc_id": "npc_tidemender" }`

## 13) Item
- Purpose: Generic inventory object.
- Required: `item_id`, `item_type`, `display_key`.
- Optional: `use_rules`.
- Validation: Must resolve icon and category.
- Safety: No manipulative scarcity messaging.
- Stub: `{ "item_id": "it_shell_ink" }`

## 14) Story Flag
- Purpose: Tracks narrative state transitions.
- Required: `flag_id`, `scope`, `set_condition`.
- Optional: `clear_condition`.
- Validation: Deterministic conditions only.
- Safety: No hidden partner-comparison logic.
- Stub: `{ "flag_id": "fl_ch1_tidegate_open" }`

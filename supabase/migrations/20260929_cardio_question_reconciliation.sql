-- ============================================================
-- Cardiovascular question-side reconciliation
--
-- The last chapter of the concept layer. Its 99 concepts were one per question,
-- every description empty, every canonical_name copied from the question's own
-- subtopic. The flashcard backfill already moved 61 cards off them onto durable
-- curriculum concepts; this moves the questions, and retires the labels.
--
-- TWO NEW CONCEPTS THAT WILL HAVE NO FLASHCARDS. Oxygen Delivery and Extraction
-- holds 6 questions and Endothelial Control of Vascular Tone holds 4, and
-- neither has a card. That is a coverage state, not a defect. Nothing existing
-- could take them: Oxygen-Binding Proteins is binding chemistry rather than
-- delivery arithmetic, and the concept already named Extraction turns out to be
-- organic chemistry liquid-liquid extraction, a pure name collision. Forcing
-- either objective into a neighbour to reach BOTH_MODALITIES would put wrong
-- evidence on a concept that is already correct about something else.
--
-- SIX LABELS SURVIVE as genuine narrower facets, keeping their evidence as
-- SECONDARY while the durable concept takes PRIMARY: isovolumic contraction,
-- the hepatic portal route, sphygmomanometry technique, plasma versus serum,
-- extramedullary hemopoiesis and lacteal routing. Two labels that an earlier
-- draft would have retained are merged instead, because re-reading them showed
-- they restate clauses already inside The Lymphatic System's own definition.
--
-- THREE QUESTIONS WERE PLACED BY READING THEM, not by their label. The clearest
-- is Peritubular Capillary Conditions, which looks like Portal Circulations
-- because it spans two beds in series, but plasma protein climbing 7.0 to 8.7
-- g/dL across the glomerulus is a Starling force argument end to end.
--
-- ORDER MATTERS TWICE. The two new concepts are created before anything is
-- repointed onto them, and every repoint happens before any deprecation,
-- because the database refuses new mappings onto a deprecated concept.
--
-- PROVENANCE. AI_PROPOSED on every row written, matching the immune migration.
-- The design was approved; the destination of each row was chosen by analysis,
-- and calling that DETERMINISTIC would describe a derivation that did not happen.
--
-- NOT TOUCHED: flashcard_concepts, flashcard content, flashcard_reviews,
-- flashcard_user_state and every FSRS field, question_attempts, learner_events,
-- learner_state_snapshots, practice_sessions. No question id changes, so every
-- historical attempt stays attached to exactly the question it was recorded
-- against. Only semantic metadata moves.
--
-- NOT DONE HERE: question-to-REASONING mappings. 13 of these questions name an
-- experimental operation and a candidate ledger exists, but question_concepts
-- stays CONTENT-only until that relation is designed.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The two question-only CONTENT concepts, with their taxonomy.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES
  ('OXYGEN_DELIVERY_EXTRACTION', 'Oxygen Delivery and Extraction', 'Oxygen content as bound plus dissolved, delivery as cardiac output times arterial content, and the extraction reserve a tissue holds between rest and maximal demand.', 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('ENDOTHELIAL_CONTROL_VASCULAR_TONE', 'Endothelial Control of Vascular Tone', 'Endothelium-derived vasodilation, chiefly nitric oxide, matching local perfusion to demand, and what is lost when the endothelium is absent or inhibited.', 'CONTENT', 'ACTIVE_SEED', 'CONCEPT')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, 'BIO_BIOCHEM', true FROM public.concepts c WHERE c.slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE')
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, 'BIOLOGY', 'PRIMARY' FROM public.concepts c WHERE c.slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE')
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'Organ Systems', true FROM public.concepts c WHERE c.slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE')
ON CONFLICT DO NOTHING;

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE');
  IF n <> 2 THEN RAISE EXCEPTION 'expected 2 new concepts, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concepts c
    WHERE c.slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE')
      AND EXISTS (SELECT 1 FROM public.concept_sections s WHERE s.concept_id=c.id)
      AND EXISTS (SELECT 1 FROM public.concept_disciplines d WHERE d.concept_id=c.id)
      AND EXISTS (SELECT 1 FROM public.concept_content_categories k WHERE k.concept_id=c.id);
  IF n <> 2 THEN RAISE EXCEPTION 'a new concept is missing taxonomy (% complete)', n; END IF;
END $$;

-- ────────────────────────────────────────────────────────────
-- 2. Repoint 89 questions onto existing durable concepts.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = v.new_id::uuid, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
FROM (VALUES
  ('26654c0c-d62d-4266-875c-febe3c84c837', 'f2cbaec1-73ad-4664-b62a-c64bdc0d0055', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('a29f5bfc-d67e-4574-8bb0-6f0bb8b27c1e', '0206d7d6-4632-4b4d-806e-8e5ac08ba49b', '1eedb534-243b-4a8f-bc20-a92225af96bd'),
  ('51a548fd-aab7-43cd-b475-5a6abb775600', 'ed01bd90-5a43-4ae5-8264-17fe936a0b22', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('a9a90378-9787-4fad-84a2-5880b1bbb97f', '4c912123-9e85-4d82-b1c4-519140030191', '6454e757-a556-40cc-8360-57ee5a379434'),
  ('85b0ce58-14b3-4a63-a4f9-d7590dc1cc4b', 'a0d1f0a6-9cc9-46a7-9941-fabb883d2196', '6454e757-a556-40cc-8360-57ee5a379434'),
  ('d3b6ec02-2563-43ab-8f1f-64f5083714b8', '1894bbfb-6960-4b29-b4c1-7ccd8e52707a', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('0abb2818-5f05-4131-9342-d87cb6b65ebd', '20fca516-bb0e-45ee-b084-093eed08b74c', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('c57ae48c-4211-46f7-8de1-376472738c57', '93acb2c6-3701-4051-87e2-866962971935', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('7fecdb6a-4cc9-49cb-adb7-1c6e956f9e14', '6b1526b3-6ff2-4041-aad3-c3af41df8ff6', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('956cb444-f865-45d7-a979-e3ce1d0e613d', '893d0b16-cdb1-4b61-8b2a-47600317d865', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('9fa69669-0077-40fd-94be-563cd507987d', '7fb7e54e-132f-4213-8300-d15d5675d09d', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('d4ddf2da-77ae-4554-96d6-a1b2885a745c', '7ab44c6d-bb07-4cc1-bc77-c4a5425b28d8', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('33a6507d-5095-4434-9e52-00727927ec71', '0f1443d3-3cae-4b20-bd55-ef5af049779f', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('15a66461-29fc-4fbb-831d-0665450e1d22', '6f83a337-c6a3-4915-8725-a8db78254b7a', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('066e3221-3e38-454a-b78d-653c9594720f', '3365b738-4588-4297-aab7-998a78c3ec38', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('624262c6-d1ce-4978-89ce-a81e560d436a', 'eeb8ab39-037e-4e87-81fc-df38aca94fab', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('285fdd0c-c557-4e3b-83e6-3c4f6de0d20f', '4eedd715-6d7e-4c2b-966b-02621cc3efbf', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('bd6df93d-c9d7-41f8-940f-569ed5c94333', '939765bc-f157-41c3-8b93-99caea4de8c3', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('c92a6edf-0c6b-4647-a339-f33f2ae0741e', 'a1b860e5-e06b-4a58-b337-0e194bb7a6f5', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('aa5762ae-9967-4b7c-8af2-6c663ef056f8', 'a2a63c0c-f896-485d-a00e-76fbd26e2b9f', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('6a0d2a94-b3c9-4337-80f1-e0477782d756', '4cf59e87-6218-415b-830f-909ff3c5a336', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('94bee6f0-381c-43b6-a39f-971ae963b087', 'a63a0a14-452f-470a-86e3-79aed3832747', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('13299d12-bf8e-48e1-8dbc-fbe0695c61b6', 'fb21fff7-6f96-48a9-8331-50c14ed6898d', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('646582fe-9f89-4400-a1a6-57516a630918', '5bf958ba-45de-4be5-84b0-d194a7cd2dc0', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('d0c9122b-c9be-4d0f-b601-2f25f74b22f9', 'fc410694-a488-4eaa-8552-4d73cde96fbd', '256b0855-3849-4d15-ae43-82071749a970'),
  ('09d76921-5e31-47ad-a6bb-0e79acdee794', '66109142-1b34-40ef-929b-e0136cfa05c4', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('bf2ab9e4-76d7-442a-8ff6-e2ed2b6d370b', '6110c6cf-a003-406b-8e5d-e79180c2451d', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('f4f6967d-17b0-406e-8f29-d423eb12a5a9', '0329e99f-05f0-4d2b-a3f0-7b238fd5e204', '7e64607e-3f09-4eb5-bce9-adb4a7c951c4'),
  ('66a446bd-e28e-45f7-b830-91739912c250', '1ab3a641-51df-4466-bf4e-71d33fe4c528', '256b0855-3849-4d15-ae43-82071749a970'),
  ('82d90487-addc-4407-89d9-b0b28ad55c88', '1eb98774-4438-4143-b9b1-a39d49aaa8b6', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('91b7c7eb-5d4e-4781-9492-3b844e26c9bb', '00ecae7a-abd7-4076-b8d2-01ad3cda1db5', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('4dffb375-805f-4660-b46a-9a44769739c1', 'ff3dc903-0723-4c2f-aa32-516b74787196', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('2c8bd087-e890-419b-a5ed-df7c33735dc0', '9846dcee-edf0-4441-bf2d-f8a5e20b3e88', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('84dd9eba-36cc-41ff-8c24-41f30009fa29', 'cdc10795-b431-4f3e-a4ea-b4fe061f8896', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('8d133e13-2fbd-498d-b6c2-eb5762aad627', 'e184dc9d-d9c8-494f-b437-a56f51454aef', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('c6955cd7-8ad7-46d3-a542-a87a05f26ddb', 'fab9d741-1289-4261-8275-de8311e673b3', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('bbff1d18-8d56-43fa-92a9-91915b550d80', 'cdbe667a-5bfd-47e0-9f65-52e6400fd392', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('e2359e00-a4dc-47f0-91b5-bc0c04d6a9e4', '7e7db27d-c791-4c82-b322-2ccb8527b7f9', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('e41b7f5e-ee09-4b40-bf05-40aa12c01a0b', '5460a73e-1915-4429-a52f-a17b0cc925bd', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('977e4895-3bd0-4ac5-83d9-c34c74f01615', '9419bd5a-7fbb-46a8-a3e3-ef88907299fe', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('631f9fbf-d212-4b3f-b740-21a0d9d56ad0', '3da30815-5963-412e-a0bf-a70354861b8a', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('02ec9bd5-7f2c-4329-8268-e1351f04f9b0', 'a69088a6-fdbb-41dd-a66c-e5617a926616', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('b0e0d63b-e04e-40cf-9234-9a532ab57b70', '04cdc833-fb0e-4ad2-ad23-f500b62aee63', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('d9ccb149-5cb5-4ecd-bf63-28bd8dbc9354', '5018b92b-5277-4589-be98-6d0f6d651caa', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('e7235937-f2bf-45b9-ad89-6cc4bc45476f', 'bab9006a-2134-472f-bdf7-c6923c5ed7b8', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('96f911ae-7bf8-4438-a567-6c31da71ae32', '6ccab44a-d226-4454-9106-081e142a3b2d', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('543a4d99-0174-4f4d-a5f9-13eb91f43d7a', 'f7b27077-8dd4-4dcc-b274-9b19399321b6', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('5f10ce6e-7ae0-48a1-8752-e2d4365db63d', '2d0a746a-efba-42fe-91df-52fcb356c4f0', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('0e740998-1f1b-4434-9fe1-b792edb53068', 'a2ac2241-84eb-49f3-8cc8-d96b77872916', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('17aa1091-ddd6-4b1e-85cf-8b74b8351b06', '99c6dbcb-765b-41f4-b59e-b8457333c0ab', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('6d94b670-aaff-4831-8ed3-717eb42ea805', 'e2f1bb9e-4462-4c5a-b8de-21baf77a15ba', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('689543ba-9498-48e3-8da6-d0d8ed16620a', 'fe2c41b3-37b2-4e2e-996f-4b16dad96537', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('88a9c043-5f62-40bc-b9b0-efa9651720e9', 'b0c29d7c-a3ad-4d97-9d3b-6d7ee530c442', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('201869cd-263f-46b3-9d5b-4c4c9ab8ecb0', '8e7b7ee3-2be6-4025-a4fc-09e138499560', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('ab35747b-852e-48b6-a097-4fe549487e21', '705117a1-e20d-4807-8ea0-d9f48d882cbc', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('f9292c77-0dca-4050-8149-3d5327b901b3', '8bf907d3-97a5-4281-93e1-d07c2fc0c859', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('2ae211e1-556c-4068-8078-8bfb3b3c9c33', '73965fba-27f8-4f56-bd8f-e20fd1b1d7a5', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('d141e943-2bb3-44d3-b378-e30779a83f7d', '9aff4289-a16e-421b-8cc8-cf2d4d13ea20', '1eedb534-243b-4a8f-bc20-a92225af96bd'),
  ('bcdaa48c-4d4d-4f1d-9ef1-4a369e322c02', '428c408b-82c0-4622-8d85-f987f8e90e1e', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('6bad7ba4-e666-4096-93ef-2c124559668c', '3fa5fdc5-7d00-4316-b833-58651cdc6bca', '7e3ddf58-1a59-49fe-b854-dfc687d2e5a1'),
  ('b35510a0-0a41-4d08-b3c8-9fdebb41e66e', 'e04c93d1-d4e1-42ab-9d7c-e86c16b16fe3', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('b50f0a84-6eda-4b25-9827-cf1321ee473f', 'a4effe03-f505-49e9-8f91-0fb7080d8317', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('a1c5610f-99a0-4bf9-b937-f38218af1ebe', '8e6b5744-3f12-4bed-b93b-d1597b750958', 'b46c7c71-4491-4aca-8d41-a3146d32728e'),
  ('883de48e-d39e-42d6-a773-76ac3160ce3a', '21f65b31-30df-4aaf-9fd5-cfc24b324e00', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('f591f209-0441-46e1-b989-04282e645e4e', '7db8db93-816d-4c29-8492-d2954418dc28', '7e3ddf58-1a59-49fe-b854-dfc687d2e5a1'),
  ('5379b470-723f-4992-bce8-d6b87a438de4', 'a6b00df5-740e-4a0d-a0b7-570d16303261', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('ec721a16-c2da-48bf-a8c2-a44199be3a4b', 'c6fe0742-326c-46ba-b59d-f609ace97860', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a836b3c5-65f5-4eb3-88b5-501ff42dec3a', '38010c06-e313-4c67-aeae-c24dc030a30b', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a75a0748-7e0c-40fb-86a7-79a4edae563b', '89e6f1fc-624f-439c-a7b8-ac80f8d891e4', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('2c851d71-8d57-4697-b090-823e4e119b7a', '895d0b8b-e138-4072-b854-8011648c9d5c', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a4ca9aee-d9df-4072-87da-143c87a99b2e', 'a87fec0b-bfa5-446b-801b-0bdcd5bfcbcd', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('36ab83cd-190d-4aaa-9030-2d29b675eb43', '9e003b95-7e1b-4e01-976e-700793c5f118', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('c86117fc-97f3-49d2-9e8d-a93838828b04', '413f074e-3d20-4a7f-b477-289addce4d2b', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('b47108f8-b7e3-4005-8959-7b7531736544', '3b83b95d-3361-477f-a04c-3099338043b2', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('2a7dc2d4-a772-4f29-bf5e-311d677d7ac1', 'ed69e952-cd54-4cef-af35-4cd96a59a0d4', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('b7160dc6-cc7d-40e7-99cf-177c76948172', 'ea198ded-4169-41ac-ab01-5967c5f903d4', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('6e9c23fe-5166-41a0-9232-f113ac6f9aea', 'fba39e9f-5c8e-4738-9bde-0ac91916929b', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('209a981a-a5c2-4a99-87a8-2042038144e0', 'c438a91a-0e46-4404-bcf9-1ff1906f1408', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('9e77626b-0191-4cee-a487-f22205217854', 'aa7dca1f-5094-4a7b-a104-4a871343f5ed', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('92430804-b0a6-40ea-a8af-9bb9acd1ccc2', 'c54531fc-d480-4ac1-b6ea-58e666f545cc', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('0b9ed6a9-cc94-49b3-a4f4-28cd76e3467f', '6d9f6b79-a551-4243-bf62-d3ac0770b7ea', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('0648672c-ee0d-43d1-9724-9c2ca4b1869a', '547c64a9-810e-4824-bec3-31f167ff03e9', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('8001c8b4-71e3-42e5-9063-7b333dead91e', 'b434a58b-0e49-4c9b-bced-a6f17dc40c25', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('8afaf51b-7a89-42c6-b335-936680cba9ce', '49759d03-bd58-43f3-96be-6d415f1a9d87', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('79419809-552a-48c9-ab01-acf5070be4a0', '002127ea-3a6c-4962-9da9-80b59b64dddc', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('463912a0-6a6c-404c-8fa7-480bd7ef4103', '78892ba7-9aeb-460a-afb6-53461bd92957', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('497265f9-c4d6-4de6-a814-31b61386888c', '160373d4-893e-42b0-9740-b5805b63f49a', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('49870984-b1ab-4410-8b5e-51a743175495', '0668690b-ecec-48a9-9cc9-d0f285b769bc', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('3add3412-304a-45ee-abf4-b2c7cb3f9581', 'f1f25479-ad20-4813-a85b-d9228f80b513', 'b46c7c71-4491-4aca-8d41-a3146d32728e')
) AS v(question_id, old_id, new_id)
WHERE qc.question_id = v.question_id::uuid AND qc.concept_id = v.old_id::uuid AND qc.role = 'PRIMARY';

-- ────────────────────────────────────────────────────────────
-- 3. Repoint 10 questions onto the two concepts just created.
--    Resolved by slug, so this cannot run before step 1.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = c.id, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
FROM (VALUES
  ('ed164739-1e35-48f9-9391-8e054e207cb2', '925e043c-e774-435e-b116-8ad18f2361cf', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('2972ed5a-dc65-48a2-86a1-2b4f3e44ef34', '95ae149a-0577-4e39-87aa-2f0f832adf76', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('adb63b32-b47b-4214-af93-a92776b00184', '875d16ca-9e54-4e8a-a454-31d9a54d9a93', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('bef5c09e-bb79-4fb6-a9dd-fc42a3cbf224', '573f0612-a068-4209-8de2-0f2353ae43f6', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('da5b9538-bc09-4308-9264-e482e7f06a7e', 'ff3893f3-dc44-4b9c-82c9-4d69fb1094f8', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('b09e69d7-8f43-4d2c-8f64-2901810dd24c', '403a4ad4-b5e3-49eb-9205-0b886a8c6f33', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('8d82c155-68e6-4af0-8613-7e12e104d234', '46f92514-dd18-4c09-8725-dc6824ac1fe3', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('fa53eeba-3ad6-4ab1-8a2f-7645952d1bce', 'e440dff1-9001-4491-bad7-cecfd7c2c596', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('a6278fcb-31e7-494b-9640-bf0d848e835a', '55fa0480-dd00-4c76-bff0-a32a803cb359', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('861036d1-da4f-4dcc-9afd-79337b207468', '7d15e371-82a9-4326-9796-cf3346680b56', 'OXYGEN_DELIVERY_EXTRACTION')
) AS v(question_id, old_id, slug)
JOIN public.concepts c ON c.slug = v.slug
WHERE qc.question_id = v.question_id::uuid AND qc.concept_id = v.old_id::uuid AND qc.role = 'PRIMARY';

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.questions qu ON qu.id = qc.question_id
    WHERE qu.topic = 'The Cardiovascular System' AND qc.role = 'PRIMARY' AND qc.source = 'AI_PROPOSED';
  IF n <> 99 THEN RAISE EXCEPTION 'expected 99 repointed mappings, found %', n; END IF;
END $$;

-- ────────────────────────────────────────────────────────────
-- 4. The one cardiovascular question that was never mapped.
--    Confinement of Clotting to the Injury Site. The two correct mechanisms are
--    plasma anticoagulants inactivating enzymes swept downstream, and intact
--    endothelium keeping subendothelial collagen covered. Both are controls on
--    the coagulation cascade.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES
  ('558c150e-d52d-45aa-ac01-9b40db16edbd'::uuid, 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'::uuid, 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED');

-- ────────────────────────────────────────────────────────────
-- 5. The six retained sub-objectives keep their evidence as SECONDARY.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES
  -- Isovolumic Contraction
  ('d4ddf2da-77ae-4554-96d6-a1b2885a745c'::uuid, '7ab44c6d-bb07-4cc1-bc77-c4a5425b28d8'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Hepatic Portal Route
  ('82d90487-addc-4407-89d9-b0b28ad55c88'::uuid, '1eb98774-4438-4143-b9b1-a39d49aaa8b6'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Sphygmomanometry Technique
  ('977e4895-3bd0-4ac5-83d9-c34c74f01615'::uuid, '9419bd5a-7fbb-46a8-a3e3-ef88907299fe'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Lacteal Routing Of Absorbed Lipid
  ('ab35747b-852e-48b6-a097-4fe549487e21'::uuid, '705117a1-e20d-4807-8ea0-d9f48d882cbc'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Plasma Versus Serum
  ('f591f209-0441-46e1-b989-04282e645e4e'::uuid, '7db8db93-816d-4c29-8492-d2954418dc28'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Extramedullary Hemopoiesis
  ('2c851d71-8d57-4697-b090-823e4e119b7a'::uuid, '895d0b8b-e138-4072-b854-8011648c9d5c'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED');

-- ────────────────────────────────────────────────────────────
-- 6. Deprecate the 93 merged labels. AFTER every repoint.
--    deprecated_by names the successor, so the lineage survives.
-- ────────────────────────────────────────────────────────────
UPDATE public.concepts c
SET status = 'DEPRECATED', deprecated_by = v.successor::uuid, version = c.version + 1, updated_at = now()
FROM (VALUES
  ('f2cbaec1-73ad-4664-b62a-c64bdc0d0055', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('0206d7d6-4632-4b4d-806e-8e5ac08ba49b', '1eedb534-243b-4a8f-bc20-a92225af96bd'),
  ('ed01bd90-5a43-4ae5-8264-17fe936a0b22', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('4c912123-9e85-4d82-b1c4-519140030191', '6454e757-a556-40cc-8360-57ee5a379434'),
  ('a0d1f0a6-9cc9-46a7-9941-fabb883d2196', '6454e757-a556-40cc-8360-57ee5a379434'),
  ('1894bbfb-6960-4b29-b4c1-7ccd8e52707a', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('20fca516-bb0e-45ee-b084-093eed08b74c', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('93acb2c6-3701-4051-87e2-866962971935', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('6b1526b3-6ff2-4041-aad3-c3af41df8ff6', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('893d0b16-cdb1-4b61-8b2a-47600317d865', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('7fb7e54e-132f-4213-8300-d15d5675d09d', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('0f1443d3-3cae-4b20-bd55-ef5af049779f', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('6f83a337-c6a3-4915-8725-a8db78254b7a', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('3365b738-4588-4297-aab7-998a78c3ec38', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('eeb8ab39-037e-4e87-81fc-df38aca94fab', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('4eedd715-6d7e-4c2b-966b-02621cc3efbf', '3d9743e0-f542-4459-8950-2f71814b826b'),
  ('939765bc-f157-41c3-8b93-99caea4de8c3', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('a1b860e5-e06b-4a58-b337-0e194bb7a6f5', 'dc363e1f-d09b-400d-998a-6812a160391e'),
  ('a2a63c0c-f896-485d-a00e-76fbd26e2b9f', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('4cf59e87-6218-415b-830f-909ff3c5a336', '0ffcd280-7fa0-403b-8e3a-93e3e6edd4d5'),
  ('a63a0a14-452f-470a-86e3-79aed3832747', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('fb21fff7-6f96-48a9-8331-50c14ed6898d', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('5bf958ba-45de-4be5-84b0-d194a7cd2dc0', 'c4d5e7aa-368a-4055-868f-5e8a49370c55'),
  ('fc410694-a488-4eaa-8552-4d73cde96fbd', '256b0855-3849-4d15-ae43-82071749a970'),
  ('66109142-1b34-40ef-929b-e0136cfa05c4', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('6110c6cf-a003-406b-8e5d-e79180c2451d', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('0329e99f-05f0-4d2b-a3f0-7b238fd5e204', '7e64607e-3f09-4eb5-bce9-adb4a7c951c4'),
  ('1ab3a641-51df-4466-bf4e-71d33fe4c528', '256b0855-3849-4d15-ae43-82071749a970'),
  ('00ecae7a-abd7-4076-b8d2-01ad3cda1db5', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('ff3dc903-0723-4c2f-aa32-516b74787196', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('9846dcee-edf0-4441-bf2d-f8a5e20b3e88', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('cdc10795-b431-4f3e-a4ea-b4fe061f8896', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('e184dc9d-d9c8-494f-b437-a56f51454aef', '3a222096-3197-43f0-9db3-a292a548beb8'),
  ('fab9d741-1289-4261-8275-de8311e673b3', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('cdbe667a-5bfd-47e0-9f65-52e6400fd392', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('7e7db27d-c791-4c82-b322-2ccb8527b7f9', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('5460a73e-1915-4429-a52f-a17b0cc925bd', '421dde0f-b686-475f-ad84-33bfb699d0c4'),
  ('3da30815-5963-412e-a0bf-a70354861b8a', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('a69088a6-fdbb-41dd-a66c-e5617a926616', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('04cdc833-fb0e-4ad2-ad23-f500b62aee63', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('5018b92b-5277-4589-be98-6d0f6d651caa', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('bab9006a-2134-472f-bdf7-c6923c5ed7b8', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('6ccab44a-d226-4454-9106-081e142a3b2d', 'e92e8e6d-308b-4362-9e7a-dc4d2da6017d'),
  ('f7b27077-8dd4-4dcc-b274-9b19399321b6', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('2d0a746a-efba-42fe-91df-52fcb356c4f0', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('a2ac2241-84eb-49f3-8cc8-d96b77872916', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('99c6dbcb-765b-41f4-b59e-b8457333c0ab', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('e2f1bb9e-4462-4c5a-b8de-21baf77a15ba', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('fe2c41b3-37b2-4e2e-996f-4b16dad96537', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('b0c29d7c-a3ad-4d97-9d3b-6d7ee530c442', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('8e7b7ee3-2be6-4025-a4fc-09e138499560', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('8bf907d3-97a5-4281-93e1-d07c2fc0c859', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('73965fba-27f8-4f56-bd8f-e20fd1b1d7a5', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('9aff4289-a16e-421b-8cc8-cf2d4d13ea20', '1eedb534-243b-4a8f-bc20-a92225af96bd'),
  ('428c408b-82c0-4622-8d85-f987f8e90e1e', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('3fa5fdc5-7d00-4316-b833-58651cdc6bca', '7e3ddf58-1a59-49fe-b854-dfc687d2e5a1'),
  ('e04c93d1-d4e1-42ab-9d7c-e86c16b16fe3', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a4effe03-f505-49e9-8f91-0fb7080d8317', 'f10687a0-8791-4c4b-8df5-511e0da2f889'),
  ('8e6b5744-3f12-4bed-b93b-d1597b750958', 'b46c7c71-4491-4aca-8d41-a3146d32728e'),
  ('21f65b31-30df-4aaf-9fd5-cfc24b324e00', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a6b00df5-740e-4a0d-a0b7-570d16303261', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('c6fe0742-326c-46ba-b59d-f609ace97860', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('38010c06-e313-4c67-aeae-c24dc030a30b', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('89e6f1fc-624f-439c-a7b8-ac80f8d891e4', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('a87fec0b-bfa5-446b-801b-0bdcd5bfcbcd', '8b9e7151-a777-46bf-93b9-67a3b26d8a93'),
  ('9e003b95-7e1b-4e01-976e-700793c5f118', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('413f074e-3d20-4a7f-b477-289addce4d2b', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('3b83b95d-3361-477f-a04c-3099338043b2', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('ed69e952-cd54-4cef-af35-4cd96a59a0d4', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('ea198ded-4169-41ac-ab01-5967c5f903d4', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('fba39e9f-5c8e-4738-9bde-0ac91916929b', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('c438a91a-0e46-4404-bcf9-1ff1906f1408', 'dac2b69f-77c0-4c76-b9e4-2498a83d3be7'),
  ('aa7dca1f-5094-4a7b-a104-4a871343f5ed', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('c54531fc-d480-4ac1-b6ea-58e666f545cc', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('6d9f6b79-a551-4243-bf62-d3ac0770b7ea', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('547c64a9-810e-4824-bec3-31f167ff03e9', '9f81042c-0568-45ca-94bc-7e47d3a3cbaa'),
  ('b434a58b-0e49-4c9b-bced-a6f17dc40c25', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('49759d03-bd58-43f3-96be-6d415f1a9d87', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('002127ea-3a6c-4962-9da9-80b59b64dddc', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('78892ba7-9aeb-460a-afb6-53461bd92957', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('160373d4-893e-42b0-9740-b5805b63f49a', '6d680059-5829-4643-a30e-8c15c8b1767f'),
  ('0668690b-ecec-48a9-9cc9-d0f285b769bc', 'b9d50d4b-2fbc-4f42-a57e-24af751a3331'),
  ('f1f25479-ad20-4813-a85b-d9228f80b513', 'b46c7c71-4491-4aca-8d41-a3146d32728e')
) AS v(id, successor)
WHERE c.id = v.id::uuid;

-- The 10 whose successor is one of the concepts created in step 1.
UPDATE public.concepts c
SET status = 'DEPRECATED', deprecated_by = s.id, version = c.version + 1, updated_at = now()
FROM (VALUES
  ('925e043c-e774-435e-b116-8ad18f2361cf', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('95ae149a-0577-4e39-87aa-2f0f832adf76', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('875d16ca-9e54-4e8a-a454-31d9a54d9a93', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('573f0612-a068-4209-8de2-0f2353ae43f6', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE'),
  ('ff3893f3-dc44-4b9c-82c9-4d69fb1094f8', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('403a4ad4-b5e3-49eb-9205-0b886a8c6f33', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('46f92514-dd18-4c09-8725-dc6824ac1fe3', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('e440dff1-9001-4491-bad7-cecfd7c2c596', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('55fa0480-dd00-4c76-bff0-a32a803cb359', 'OXYGEN_DELIVERY_EXTRACTION'),
  ('7d15e371-82a9-4326-9796-cf3346680b56', 'OXYGEN_DELIVERY_EXTRACTION')
) AS v(id, slug)
JOIN public.concepts s ON s.slug = v.slug
WHERE c.id = v.id::uuid;

-- ────────────────────────────────────────────────────────────
-- 7. Verification inside the transaction.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  SELECT count(*) INTO v FROM (
    SELECT qu.id FROM public.questions qu
    LEFT JOIN public.question_concepts qc ON qc.question_id = qu.id AND qc.role = 'PRIMARY'
    WHERE qu.topic = 'The Cardiovascular System'
    GROUP BY qu.id HAVING count(qc.concept_id) <> 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% cardiovascular questions lack exactly one PRIMARY', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF v <> 0 THEN RAISE EXCEPTION '% mappings still point at a deprecated concept', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.object_type <> 'CONTENT';
  IF v <> 0 THEN RAISE EXCEPTION '% question mappings point at a non-CONTENT object', v; END IF;

  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED';
  IF v <> 176 THEN RAISE EXCEPTION 'expected 176 deprecated concepts, found %', v; END IF;
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED' AND deprecated_by IS NULL;
  IF v <> 0 THEN RAISE EXCEPTION '% deprecated concepts have no successor', v; END IF;
  SELECT count(*) INTO v FROM public.concepts c
    WHERE c.deprecated_by IS NOT NULL AND NOT EXISTS (SELECT 1 FROM public.concepts s WHERE s.id = c.deprecated_by);
  IF v <> 0 THEN RAISE EXCEPTION '% dangling successor references', v; END IF;

  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard mappings changed: %', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2673 THEN RAISE EXCEPTION 'expected 2673 question mappings, found %', v; END IF;

  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1129 THEN RAISE EXCEPTION 'expected 1129 concepts, found %', v; END IF;

  SELECT count(*) INTO v FROM (SELECT question_id FROM public.question_concepts
    WHERE role = 'PRIMARY' GROUP BY question_id HAVING count(*) > 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% questions carry more than one PRIMARY', v; END IF;
END $$;

-- The durable cardiovascular layer and what it now holds.
SELECT c.canonical_name,
       count(*) FILTER (WHERE qc.role = 'PRIMARY') AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c
LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.status = 'ACTIVE_SEED' AND EXISTS (
  SELECT 1 FROM public.question_concepts x JOIN public.questions y ON y.id = x.question_id
  WHERE x.concept_id = c.id AND y.topic = 'The Cardiovascular System')
GROUP BY c.id, c.canonical_name ORDER BY 2 DESC;

-- The two question-only concepts. Expect 6 and 4 questions, 0 flashcards each.
SELECT c.canonical_name, count(qc.*) AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.slug IN ('OXYGEN_DELIVERY_EXTRACTION', 'ENDOTHELIAL_CONTROL_VASCULAR_TONE')
GROUP BY c.id, c.canonical_name;

COMMIT;

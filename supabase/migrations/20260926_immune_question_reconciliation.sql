-- ============================================================
-- Immune question-side reconciliation
--
-- Moves all 90 Immune questions onto durable curriculum concepts and retires the
-- question-instance labels they were filed under. This is the other half of the
-- backfill: the cards already point at these 19 concepts, and after this the
-- questions do too, so memory and application finally share one id.
--
-- WHAT THE OLD LABELS WERE. 89 objects for 90 questions, one question each, every
-- description empty, every canonical_name copied verbatim from the question's own
-- subtopic. They are a question index wearing concept clothing. Retiring them is
-- not a cleanup of untidy names, it is removing identities that cannot carry
-- evidence past the life of a single question.
--
-- NOTHING IS DELETED. Every repoint is an UPDATE that preserves the row and its
-- history, and the manifest records each question's old concept_id so this is
-- readable backwards. Each retired label is DEPRECATED with deprecated_by
-- pointing at its successor, so an attempt recorded against it years from now
-- can still be explained.
--
-- SIX LABELS SURVIVE. Skin as a Physical Barrier, Gastric Acid as a Chemical
-- Barrier, Colonization Resistance by Resident Flora, Chemotaxis and Gradient
-- Sensing, Population Value of MHC Allele Diversity and Epitope Size and
-- Response Diversity are genuinely narrower facets, not synonyms. Each keeps its
-- evidence as a SECONDARY mapping on the same question while the durable concept
-- takes PRIMARY, and each is flagged for the hierarchy review the ontology
-- cannot express yet. Four other class-A labels MERGE instead, because they name
-- the durable concept's whole subject rather than a part of it.
--
-- ORDER MATTERS. Repointing happens BEFORE deprecation, because the database
-- refuses new mappings onto a deprecated concept.
--
-- PROVENANCE. The old mappings were DETERMINISTIC, meaning derived by exact
-- subtopic match. Their destination is now chosen by analysis, so every row this
-- migration writes becomes AI_PROPOSED. Claiming DETERMINISTIC for a judgement
-- would be a lie about how the row was produced.
--
-- NOT TOUCHED: flashcard_concepts, flashcard_reviews, flashcard_user_state and
-- every FSRS field, question_attempts, learner_events, learner_state_snapshots,
-- practice_sessions. Questions keep their ids, so historical attempts stay
-- attached to exactly the same questions. Only the semantic metadata moves.
--
-- NOT DONE HERE: question-to-REASONING mappings. 23 of these questions name an
-- experimental operation, and a candidate report exists, but question_concepts
-- stays CONTENT-only until that relation is designed and approved.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. Repoint 89 question mappings onto durable concepts.
--    UPDATE in place: the row, and anything referencing it, survives.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = v.new_id::uuid,
    mapping_status = 'AI_PROPOSED',
    source = 'AI_PROPOSED'
FROM (VALUES
  ('cc61ca2d-83ab-4371-b0e6-c19bcba36a31', '00bd59c2-cc4d-4c5b-9385-a454cc8800eb', '033dc305-59e3-419e-94ce-99f66738123e'),
  ('ef369695-bec7-4a26-ac6f-d3d7a8317aeb', '118bbbdd-7d90-4aa4-878d-b38057f402e2', '033dc305-59e3-419e-94ce-99f66738123e'),
  ('f1f984a4-c6ab-43db-8421-6285098111e1', 'fdcc5b4b-f4bf-48d5-85cc-33030ee41771', '033dc305-59e3-419e-94ce-99f66738123e'),
  ('ff8c0781-da96-4041-ba3d-36c7f1589e3a', '676eba8f-88c4-4614-b11a-93b919001ad0', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('b3514136-d6e6-493c-8994-e23353ab28ca', '1e3614c2-4449-46bf-a9be-c840092629e4', '033dc305-59e3-419e-94ce-99f66738123e'),
  ('572bf827-da8b-49a8-be6a-3fc1bcde0534', '30b9960a-5134-4870-a2e1-f98a3efda6c6', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('2365d44b-9b50-40f4-92d1-124aeca6870f', '8861c6cb-4be2-4eb9-9a58-e865c26adfa8', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('70e5a2cd-25fd-4c30-8266-995a4756f3c9', '82393797-bd21-49f1-a52c-4fcaedb1c861', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('b914ca6b-0fd8-4cb2-a358-acaca356fd0a', '67c691dd-ac61-43f3-8cf5-8a76f5a57591', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('37bf06ad-2c7f-46dd-a8e4-709f8601823c', '9baaa442-814e-4c9e-921d-185f3e9d1c87', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('871a9978-9dea-4486-9a99-f4844a3ae9de', '30dbdc9f-eeb6-481d-82b0-2c5912d09bd7', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('addd087e-9cd4-4ef0-b198-7b3090ec90d7', '0ad909f4-f0f2-4839-b134-9d4b105a8887', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('de866d99-0d37-4de8-a0bb-c79eae15de2a', '3c03f205-cbd5-4abc-b333-d0dcc4f1a595', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('26e09ba7-77f9-4834-b1c1-2bacc1de5451', '67c0365a-6973-4d88-af0c-dbe7a9a45a0c', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('61879463-3499-4a2b-9648-0949493434a9', '672b19e9-7740-4c1b-92f7-32137bc92962', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('dd698b6c-9dea-46ab-af2f-9f7cc361f8aa', '786ad010-a024-42f4-bd69-bcae78b58265', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('10a94fd5-3f1b-426b-a691-6ad724cfebc4', '06805e58-1272-4cd4-85fa-d1a27ff2116a', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('576817f5-483c-4890-b117-d5165c6e712a', 'e6b6cc8e-d06a-4cfc-afa5-aaa58d7ee2ee', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('b65eb364-7599-48ae-9cb4-6323389e4cc8', 'cfe809cc-551e-4da4-b2af-bc023f2c1215', '600eb3ad-c2ba-48f3-b072-d427ec63d274'),
  ('b8a0d9e2-da1c-4cea-aebb-e759dc7f8675', '8a9defff-0068-4d3e-b13f-7e60c32007f5', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('4e3baabb-b09c-42d0-ad86-567a711f440d', '650951b8-58bb-4bd0-b722-7bc5c47af91c', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('81cdc94c-e164-4d2a-a0d4-370a934dd732', 'b362915d-1b7e-41a4-bb5b-f8267f3894e3', '600eb3ad-c2ba-48f3-b072-d427ec63d274'),
  ('dc23b0ba-41b3-4c1a-a070-3e9c1fadac96', '670509d2-82a7-4ce6-bb18-881cb5e9352c', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('7f5e783b-6618-4bf5-bf38-b35ea837d63b', '93158af5-901f-4106-ac69-19bd2dedcd82', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('dfce2191-4506-40a4-bf3e-d7211fbec14b', 'b8a1a5b9-b15c-45ab-bc0b-1161050bc61c', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('78502ace-b477-4b9a-9cf7-904d0c09efd6', 'd08d552e-c933-48de-8616-6e82cf497e00', '101353ee-f01c-42dc-9d79-440ed2dec73d'),
  ('1f8100b0-c015-46fb-97d3-7524eea1703f', '566ab4ae-7a2f-42be-a854-01e84bd8c3f9', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('839022d1-048b-45bc-b526-41bfb1337a70', 'ce73e4ce-9389-4be6-899e-28bedb64c7c3', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('864760c9-99ef-40c7-a6d7-5e0395273989', '7e4504bd-5849-4171-bacc-ee620e7d2649', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('41554ad6-1968-46e3-9952-a2669207e974', 'bac3c212-fe32-4c4b-94e4-072febf9d7da', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('a72d6b7c-220b-4ea1-9657-107d608292d5', '42f39dae-087b-4403-b33d-0a1f377ec022', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('584d437a-3a02-4c03-93bd-a2fd1cb3c50a', 'f9133df3-381a-444e-81b9-74a1b93947e4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('50117ffe-e9db-48d3-98f9-4490ab618273', 'd323773e-8187-4c96-a030-08262037ace4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('012d10a3-4411-4e6b-8323-8a1e2825e595', '600c4f52-da88-4498-a692-5c105f928837', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('71e81dfd-0b97-4bba-91c7-2a7a439ed197', '95500058-52c1-414e-8f8d-7a3ed3053da4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('45b6585b-a3d3-4092-9cf9-d184a6931d93', '92537c1d-0c6c-4eb2-9959-890756524641', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('dcfbe77b-8d15-441a-ae74-93ec1b46dd2c', '04ae5503-159f-4deb-b210-7ba619c23fb7', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('65314202-aa73-4301-935e-8e24961d7b5f', '5988f04c-ce90-418b-81e4-5f3ba6238b42', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('26a77350-de62-40e4-8b72-07ee2362764a', '8f00cabd-3618-4fba-a243-254c74c488b8', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('a0863446-8060-435d-aa37-2373ec936ad8', '6a739892-2de4-41bd-9ef8-32483f7c4d75', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('b5527bc1-19e2-4410-baf5-d439853476e0', '9638056d-6826-4846-b4eb-8580c509ce04', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('b265fad0-64eb-4fa6-aab9-e966cd7760a5', 'd9e604c8-c82d-4311-8303-5fbd488d6351', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('1c1e14d4-2d03-434f-b3a1-f87c5882ca82', '89c87421-53e6-4972-acde-8571951f20b8', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('b0b0f0ba-7309-45a9-b73d-ddfa4d127f98', 'b589f745-71d3-4780-ad29-d3c887873d20', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('282ca647-02a9-4319-b240-cbff276485dd', 'faafbb82-ce21-4f20-b819-9758f2f88f6e', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('df64f6ea-6ba0-48be-bba9-8d005cc9a78b', '3393ef8b-28ab-4099-aae0-26d3ca706ae0', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('d2816b7b-ddd5-4aab-af5d-5d656bff0249', '6ec33935-26c2-4001-a6cb-df97404f0995', 'b30b1d54-48c4-4754-a098-ae0dbc3306c7'),
  ('113e0573-ee97-43f0-9d0e-938eb5a47ddf', '6550e219-b686-42a2-aa07-fc6b5e877d6f', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('4f24bcaf-71a2-4160-8d34-5ebac433f1d1', 'e95aa087-218d-4479-b4cb-bdb551ca939c', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('d94c841b-bcf0-47ef-b485-58d6687731e2', '7fa72870-e377-4c26-a753-0e87cf7f4150', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('4b75b5f6-2ed6-4311-90ad-5d0529151aa1', '5873d134-5d5a-4730-970b-cae2c9829571', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('f382f187-ae7b-46bb-a7dc-246173cf3633', '821d2804-721c-4f8f-a35f-1345a267cf49', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('3728898c-3f11-400b-825b-54fad43f1f69', 'a8cc52e0-1ddf-4627-8a3b-986d142fd737', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('34957a90-a7d5-42ff-9b34-889ecdfe209d', '88563bf9-780b-4f19-893b-9f049d659a47', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('7d9469fb-32cb-46c3-bbae-7dfaf927d273', 'df745247-6119-4b41-919d-23528b846db7', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('44f64142-0ca1-4220-a205-9677b56f69d5', '26f6466d-56a1-45c6-b07c-eb067ef1a411', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('98550645-bc17-499d-8c32-8481951a1214', 'eac6361f-43c9-4fa8-96f9-3bdb406bd289', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('d70c71bf-9e2f-4f01-b5f2-0d7a4bbf1a9b', '2dae1caa-b849-4601-8ba0-1385082c8d23', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('a56c4029-8b23-4c79-aa53-d387558b61dd', '26996ba6-d683-4ae2-a3e1-10e253afb6e9', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('ae93636f-a9dc-40c0-8d63-73abde45bad4', '05562a2e-556b-4cc5-b4c2-a1a827ff5e95', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('de645cc8-3194-4f5b-b447-e2feb2ed359b', '4af483df-0172-467d-8fd4-69ca72382aef', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('c81dddc2-2661-47af-8075-6735bdd42f9c', 'a6ac0bcb-a2da-4a6e-9460-fe4d19266b5c', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('0efd9602-ce38-4d4a-a220-abfe86aad0c7', '1cd679b7-5698-411f-bb6d-334e0c35fc94', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('397b577d-f7f0-4470-9c5a-bd54e8d864f4', '1b336ecd-0d68-4466-b869-bffe07f31032', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('645e6716-886f-425d-a81c-ae1dd06d365b', '8ed9c7b9-1bf5-4ef8-ab73-87764d06174f', '5d95ee1c-65c3-404f-b2d3-6f96494c11bb'),
  ('2cde97d4-bd5e-427c-878c-f0e01a5a265d', '43f4e555-66c9-4f58-9822-ba2680e43d7a', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('2674e7f3-7623-4549-8ecd-20fffe3b9363', 'f0164350-d54e-46e8-bc23-b41e35b3648e', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('75fabca9-8399-4790-8de5-1bbab407ef9e', '7123e0df-3e33-46ac-9352-d65cf782b30c', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('9cc99967-e918-4299-bc63-1ae4c960074d', 'bf2247bf-7c48-43f0-a06b-96f021678acf', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('345a55eb-2c8a-432a-ad68-e118d650d128', '71e4e0ef-bf1e-4278-b5af-30e65ce9ec19', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('da37abf4-0358-4e04-801c-e9e6aef7b9e7', '7b2b21f4-d11d-42e9-930d-fdfe754e1a50', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('20a87354-8b62-4a10-9d86-d6c9908e0938', 'f462d647-1145-4851-9baf-7386a011acb2', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('76d63427-8cda-4091-a9fb-1765e24e9d1b', 'cf898ed6-0965-49cc-9b28-9e40090a3700', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('bd922c3f-7386-4f37-bdc5-4ea48a1ac20a', 'a5c3d077-be06-4e76-9fa9-0048bc2ecbab', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('bdeab519-a0c9-42f2-a144-f27c76efbbec', '9995af30-aed3-4a97-94e4-0160b71d942f', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('21e414ff-8a51-49cc-8177-943240186651', 'a73e673a-0e5c-4b35-b3cc-00393bbac75b', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('d6643f6f-b8a0-4cdd-901a-e7a39fcd19db', '568fee4a-f4d1-464d-9223-284602d63bac', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('34c11e13-aa71-4ef4-a9fb-4c888acef2d9', '1c9c05fc-1a15-479a-892b-3e1b442078e6', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('0f6e3fe7-6bc8-4406-989e-826e26300ce8', '64f55e86-3397-484d-a9f7-12f4dc2658fe', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('cb8b3fa1-7c4e-4a9e-8f7c-a93fb7cb99ff', '74fdf72e-f37d-4799-8579-5d323cecdf7d', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('828ed471-6fcb-4ba4-9818-566fe1425988', 'acc24b86-f8a2-4099-a58c-ed8fcfd098fe', '4f51a89d-fc0c-4d46-aa08-c6413a1b76a7'),
  ('7d114eed-838e-4438-8473-872fad57b4e6', '30c1ef45-9ce0-47e0-8361-11f8ebddadaa', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('d22628c6-0127-45ac-bc8f-d4ccc3b13650', '3715fbc9-2fce-4d31-9dbb-13c14954c5b3', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('6d375224-96f6-4985-839d-80492963ee30', '6eb1c5ec-4c33-46a1-8d1a-797657aca537', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('9acc6a94-4cba-4e69-a114-f74383244c88', 'a8276253-b93a-4783-ac3d-4e88db977abd', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('be78788b-ea91-4598-8785-4529e578e8e0', '9c0756fd-5341-422c-9898-bc346b0a7502', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('508e1dbf-d592-4645-a6bd-88302789985f', '3aa63e2f-cfaa-440b-bd57-6242412133f2', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('0243cc4d-deb0-4671-b69c-11adf49b06c0', '4b81a069-fa14-45cd-88ef-425053674bf5', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('15b20cb7-b990-41db-8dc5-f85cef61b09b', '880e05ea-3dc0-46b5-a4b8-2084d27f4439', '289942e3-41e7-4f29-9fc8-42da51ebc93b')
) AS v(question_id, old_id, new_id)
WHERE qc.question_id = v.question_id::uuid
  AND qc.concept_id  = v.old_id::uuid
  AND qc.role = 'PRIMARY';

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.questions qu ON qu.id = qc.question_id
    WHERE qu.topic = 'The Immune System' AND qc.role = 'PRIMARY' AND qc.source = 'AI_PROPOSED';
  IF n <> 89 THEN RAISE EXCEPTION 'expected 89 repointed immune mappings, found %', n; END IF;
END $$;

-- ────────────────────────────────────────────────────────────
-- 2. The one Immune question that was never mapped.
--    Random Repertoire and the Need for Tolerance. The stem describes random
--    gene-segment joining, but the tested inference is why a dedicated screen is
--    needed at all: blind recombination inevitably produces self-fitting sites.
--    That is negative selection, not diversity generation, which is why the
--    earlier design's destination was wrong.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES
  ('1094f719-1ba1-42ad-81b9-93ca0454f045'::uuid, 'aa9f0b30-2540-400e-a1be-9d691f764688'::uuid, 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED');

-- ────────────────────────────────────────────────────────────
-- 3. The six retained sub-objectives keep their evidence as SECONDARY.
--    question_concepts_one_primary allows exactly one PRIMARY per question and
--    any number of SECONDARY rows, so the durable concept and the narrower facet
--    can both be true of the same question without competing.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES
  -- Skin as a Physical Barrier
  ('cc61ca2d-83ab-4371-b0e6-c19bcba36a31'::uuid, '00bd59c2-cc4d-4c5b-9385-a454cc8800eb'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Gastric Acid as a Chemical Barrier
  ('ef369695-bec7-4a26-ac6f-d3d7a8317aeb'::uuid, '118bbbdd-7d90-4aa4-878d-b38057f402e2'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Colonization Resistance by Resident Flora
  ('f1f984a4-c6ab-43db-8421-6285098111e1'::uuid, 'fdcc5b4b-f4bf-48d5-85cc-33030ee41771'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Chemotaxis and Gradient Sensing
  ('26e09ba7-77f9-4834-b1c1-2bacc1de5451'::uuid, '67c0365a-6973-4d88-af0c-dbe7a9a45a0c'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Population Value of MHC Allele Diversity
  ('a72d6b7c-220b-4ea1-9657-107d608292d5'::uuid, '42f39dae-087b-4403-b33d-0a1f377ec022'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  -- Epitope Size and Response Diversity
  ('34957a90-a7d5-42ff-9b34-889ecdfe209d'::uuid, '88563bf9-780b-4f19-893b-9f049d659a47'::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED');

-- ────────────────────────────────────────────────────────────
-- 4. Aliases, for the four merged labels that name a real searchable term.
--    Declined for the other 79: "Why A Coated Organism Is The One That
--    Overwhelms" is a question stem, and 79 of those would turn the alias table
--    into a scenario index. deprecated_by already preserves the lineage.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concept_aliases (concept_id, alias, alias_type, source, status)
VALUES
  ('aa9f0b30-2540-400e-a1be-9d691f764688'::uuid, 'Two Screens During Lymphocyte Maturation', 'LEGACY_NAME', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('97eed562-e457-4ae5-a6c2-2693bb5badd5'::uuid, 'Origin of B Lineage Binding Diversity', 'LEGACY_NAME', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b25681ed-7cf3-438e-9f4f-e15088bb98b7'::uuid, 'Selection Versus Instruction by Antigen', 'LEGACY_NAME', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d6a554ad-4e6a-43f5-8509-fc9c7b072162'::uuid, 'Two Site Design of Lymphocyte Production', 'LEGACY_NAME', 'AI_PROPOSED', 'AI_PROPOSED')
ON CONFLICT DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 5. Deprecate the 83 merged labels. AFTER the repoint, never before.
--    status DEPRECATED blocks new mappings; deprecated_by names the successor so
--    the lineage is recoverable. The object itself stays.
-- ────────────────────────────────────────────────────────────
UPDATE public.concepts c
SET status = 'DEPRECATED',
    deprecated_by = v.successor::uuid,
    version = c.version + 1,
    updated_at = now()
FROM (VALUES
  ('676eba8f-88c4-4614-b11a-93b919001ad0', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('1e3614c2-4449-46bf-a9be-c840092629e4', '033dc305-59e3-419e-94ce-99f66738123e'),
  ('30b9960a-5134-4870-a2e1-f98a3efda6c6', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('8861c6cb-4be2-4eb9-9a58-e865c26adfa8', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('82393797-bd21-49f1-a52c-4fcaedb1c861', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('67c691dd-ac61-43f3-8cf5-8a76f5a57591', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('9baaa442-814e-4c9e-921d-185f3e9d1c87', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('30dbdc9f-eeb6-481d-82b0-2c5912d09bd7', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('0ad909f4-f0f2-4839-b134-9d4b105a8887', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('3c03f205-cbd5-4abc-b333-d0dcc4f1a595', 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'),
  ('672b19e9-7740-4c1b-92f7-32137bc92962', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('786ad010-a024-42f4-bd69-bcae78b58265', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('06805e58-1272-4cd4-85fa-d1a27ff2116a', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('e6b6cc8e-d06a-4cfc-afa5-aaa58d7ee2ee', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('cfe809cc-551e-4da4-b2af-bc023f2c1215', '600eb3ad-c2ba-48f3-b072-d427ec63d274'),
  ('8a9defff-0068-4d3e-b13f-7e60c32007f5', '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'),
  ('650951b8-58bb-4bd0-b722-7bc5c47af91c', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('b362915d-1b7e-41a4-bb5b-f8267f3894e3', '600eb3ad-c2ba-48f3-b072-d427ec63d274'),
  ('670509d2-82a7-4ce6-bb18-881cb5e9352c', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('93158af5-901f-4106-ac69-19bd2dedcd82', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('b8a1a5b9-b15c-45ab-bc0b-1161050bc61c', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('d08d552e-c933-48de-8616-6e82cf497e00', '101353ee-f01c-42dc-9d79-440ed2dec73d'),
  ('566ab4ae-7a2f-42be-a854-01e84bd8c3f9', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('ce73e4ce-9389-4be6-899e-28bedb64c7c3', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('7e4504bd-5849-4171-bacc-ee620e7d2649', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('bac3c212-fe32-4c4b-94e4-072febf9d7da', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('f9133df3-381a-444e-81b9-74a1b93947e4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('d323773e-8187-4c96-a030-08262037ace4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('600c4f52-da88-4498-a692-5c105f928837', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('95500058-52c1-414e-8f8d-7a3ed3053da4', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('92537c1d-0c6c-4eb2-9959-890756524641', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('04ae5503-159f-4deb-b210-7ba619c23fb7', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('5988f04c-ce90-418b-81e4-5f3ba6238b42', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('8f00cabd-3618-4fba-a243-254c74c488b8', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('6a739892-2de4-41bd-9ef8-32483f7c4d75', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('9638056d-6826-4846-b4eb-8580c509ce04', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('d9e604c8-c82d-4311-8303-5fbd488d6351', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('89c87421-53e6-4972-acde-8571951f20b8', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('b589f745-71d3-4780-ad29-d3c887873d20', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('faafbb82-ce21-4f20-b819-9758f2f88f6e', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('3393ef8b-28ab-4099-aae0-26d3ca706ae0', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('6ec33935-26c2-4001-a6cb-df97404f0995', 'b30b1d54-48c4-4754-a098-ae0dbc3306c7'),
  ('6550e219-b686-42a2-aa07-fc6b5e877d6f', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('e95aa087-218d-4479-b4cb-bdb551ca939c', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('7fa72870-e377-4c26-a753-0e87cf7f4150', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('5873d134-5d5a-4730-970b-cae2c9829571', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('821d2804-721c-4f8f-a35f-1345a267cf49', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('a8cc52e0-1ddf-4627-8a3b-986d142fd737', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('df745247-6119-4b41-919d-23528b846db7', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('26f6466d-56a1-45c6-b07c-eb067ef1a411', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('eac6361f-43c9-4fa8-96f9-3bdb406bd289', '97eed562-e457-4ae5-a6c2-2693bb5badd5'),
  ('2dae1caa-b849-4601-8ba0-1385082c8d23', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('26996ba6-d683-4ae2-a3e1-10e253afb6e9', 'c0290780-23e3-4fde-bfd8-062c31ff3183'),
  ('05562a2e-556b-4cc5-b4c2-a1a827ff5e95', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('4af483df-0172-467d-8fd4-69ca72382aef', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('a6ac0bcb-a2da-4a6e-9460-fe4d19266b5c', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('1cd679b7-5698-411f-bb6d-334e0c35fc94', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('1b336ecd-0d68-4466-b869-bffe07f31032', 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'),
  ('8ed9c7b9-1bf5-4ef8-ab73-87764d06174f', '5d95ee1c-65c3-404f-b2d3-6f96494c11bb'),
  ('43f4e555-66c9-4f58-9822-ba2680e43d7a', 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'),
  ('f0164350-d54e-46e8-bc23-b41e35b3648e', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('7123e0df-3e33-46ac-9352-d65cf782b30c', 'c57052ab-6946-4954-af7f-0c28696ab6f9'),
  ('bf2247bf-7c48-43f0-a06b-96f021678acf', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('71e4e0ef-bf1e-4278-b5af-30e65ce9ec19', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('7b2b21f4-d11d-42e9-930d-fdfe754e1a50', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('f462d647-1145-4851-9baf-7386a011acb2', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('cf898ed6-0965-49cc-9b28-9e40090a3700', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('a5c3d077-be06-4e76-9fa9-0048bc2ecbab', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('9995af30-aed3-4a97-94e4-0160b71d942f', '7c17a499-a8f2-4931-bead-9210667261bc'),
  ('a73e673a-0e5c-4b35-b3cc-00393bbac75b', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('568fee4a-f4d1-464d-9223-284602d63bac', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('1c9c05fc-1a15-479a-892b-3e1b442078e6', 'b5436b16-5a57-4871-9162-54143bb450a7'),
  ('64f55e86-3397-484d-a9f7-12f4dc2658fe', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('74fdf72e-f37d-4799-8579-5d323cecdf7d', 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'),
  ('acc24b86-f8a2-4099-a58c-ed8fcfd098fe', '4f51a89d-fc0c-4d46-aa08-c6413a1b76a7'),
  ('30c1ef45-9ce0-47e0-8361-11f8ebddadaa', 'aa9f0b30-2540-400e-a1be-9d691f764688'),
  ('3715fbc9-2fce-4d31-9dbb-13c14954c5b3', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('6eb1c5ec-4c33-46a1-8d1a-797657aca537', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('a8276253-b93a-4783-ac3d-4e88db977abd', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('9c0756fd-5341-422c-9898-bc346b0a7502', '0e58b369-76cc-4aae-a98c-df7c725807af'),
  ('3aa63e2f-cfaa-440b-bd57-6242412133f2', '289942e3-41e7-4f29-9fc8-42da51ebc93b'),
  ('4b81a069-fa14-45cd-88ef-425053674bf5', '91e4abb7-da27-4fcc-967a-adf851aa100e'),
  ('880e05ea-3dc0-46b5-a4b8-2084d27f4439', '289942e3-41e7-4f29-9fc8-42da51ebc93b')
) AS v(id, successor)
WHERE c.id = v.id::uuid;

-- ────────────────────────────────────────────────────────────
-- 6. Verification inside the transaction.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  -- Every Immune question now carries exactly one PRIMARY.
  SELECT count(*) INTO v FROM (
    SELECT qu.id FROM public.questions qu
    LEFT JOIN public.question_concepts qc ON qc.question_id = qu.id AND qc.role = 'PRIMARY'
    WHERE qu.topic = 'The Immune System'
    GROUP BY qu.id HAVING count(qc.concept_id) <> 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% immune questions lack exactly one PRIMARY concept', v; END IF;

  -- No question mapping may point at a DEPRECATED concept.
  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF v <> 0 THEN RAISE EXCEPTION '% mappings still point at a deprecated concept', v; END IF;

  -- question_concepts stays CONTENT-only.
  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.object_type <> 'CONTENT';
  IF v <> 0 THEN RAISE EXCEPTION '% question mappings point at a non-CONTENT object', v; END IF;

  -- Exactly 83 labels deprecated, each with a successor.
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED';
  IF v <> 83 THEN RAISE EXCEPTION 'expected 83 deprecated concepts, found %', v; END IF;
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED' AND deprecated_by IS NULL;
  IF v <> 0 THEN RAISE EXCEPTION '% deprecated concepts have no successor', v; END IF;

  -- Flashcard mappings untouched.
  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard mappings changed: %', v; END IF;

  -- Question mappings: 2659 + 1 insert + 6 secondary.
  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2666 THEN RAISE EXCEPTION 'expected 2666 question mappings, found %', v; END IF;

  -- Ontology size unchanged: this migration creates no objects.
  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1127 THEN RAISE EXCEPTION 'concept count changed: %', v; END IF;
END $$;

-- Every durable Immune concept and what it now holds.
SELECT c.canonical_name,
       count(*) FILTER (WHERE qc.role = 'PRIMARY')   AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c
LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.id IN ('033dc305-59e3-419e-94ce-99f66738123e'::uuid, '289942e3-41e7-4f29-9fc8-42da51ebc93b'::uuid, 'b5436b16-5a57-4871-9162-54143bb450a7'::uuid, 'c9f01c85-2146-48d3-9579-2f7696cb0cb7'::uuid, '8d1e8fc5-2748-4209-9564-a69ba85b9d8c'::uuid, '600eb3ad-c2ba-48f3-b072-d427ec63d274'::uuid, 'd6a554ad-4e6a-43f5-8509-fc9c7b072162'::uuid, 'c0290780-23e3-4fde-bfd8-062c31ff3183'::uuid, '91e4abb7-da27-4fcc-967a-adf851aa100e'::uuid, '101353ee-f01c-42dc-9d79-440ed2dec73d'::uuid, 'aa9f0b30-2540-400e-a1be-9d691f764688'::uuid, '97eed562-e457-4ae5-a6c2-2693bb5badd5'::uuid, 'b30b1d54-48c4-4754-a098-ae0dbc3306c7'::uuid, 'b25681ed-7cf3-438e-9f4f-e15088bb98b7'::uuid, 'fec64a8c-8d0a-4d4d-8e0c-425566410e06'::uuid, 'c57052ab-6946-4954-af7f-0c28696ab6f9'::uuid, '5d95ee1c-65c3-404f-b2d3-6f96494c11bb'::uuid, '7c17a499-a8f2-4931-bead-9210667261bc'::uuid, '4f51a89d-fc0c-4d46-aa08-c6413a1b76a7'::uuid, '0e58b369-76cc-4aae-a98c-df7c725807af'::uuid)
GROUP BY c.id, c.canonical_name ORDER BY 2 DESC;

-- The six retained sub-objectives: zero PRIMARY, one SECONDARY each.
SELECT c.canonical_name, qc.role, count(*)
FROM public.concepts c JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.id IN ('00bd59c2-cc4d-4c5b-9385-a454cc8800eb'::uuid, '118bbbdd-7d90-4aa4-878d-b38057f402e2'::uuid, 'fdcc5b4b-f4bf-48d5-85cc-33030ee41771'::uuid, '67c0365a-6973-4d88-af0c-dbe7a9a45a0c'::uuid, '42f39dae-087b-4403-b33d-0a1f377ec022'::uuid, '88563bf9-780b-4f19-893b-9f049d659a47'::uuid)
GROUP BY 1,2 ORDER BY 1;

COMMIT;

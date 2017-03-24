--
-- PostgreSQL database dump
--

CREATE TABLE _nice_binary (
    hash character(40) NOT NULL,
    size bigint NOT NULL,
    mime_type character varying(255) NOT NULL,
    data oid,
    sha2 character(44)
);

SELECT pg_catalog.lo_create('198485881');
SELECT pg_catalog.lo_create('198485882');
SELECT pg_catalog.lo_create('198485883');
SELECT pg_catalog.lo_create('198485884');
SELECT pg_catalog.lo_create('198485885');

INSERT INTO _nice_binary (hash, size, mime_type, data, sha2)
VALUES
    ('43fe96d43c21d1f86780f47b28fe24f142c395d9', 6842, '',             198485881, null),
    ('8bacf7b5aeb31e6d278598d4be2b263c8d53e862',  125, 'octet/stream', 198485882, null),
    ('0000000000000000000000000000000000000000',   44, 'unused',               0,
                                                 '0000000000000000000000000000000000000000000='),
    ('da39a3ee5e6b4b0d3255bfef95601890afd80709',    0, 'octet/stream', 198485883, null),
    ('4694849b7ceeae0e5254689ff1f352735581d6ec',   12, 'text/plain',   198485884, null),
    ('d0706a2d42b415eaf546865acf6287fc8ac1f0e5',   81, 'octet/stream', 198485885, null);

BEGIN;

SELECT pg_catalog.lo_open('198485881', 131072);
SELECT pg_catalog.lowrite(0, '\x4b1af8cf4c4faef45ba5a2155c31ed67ca71d3a5bbf10401a39c5e7e70a7446bcc3d4917cab29f58af9b2f22e3719f547a81546f31d9bc2a436b5d18ee6887466ea0220de294f82e0d9993f2b950380ea999be15a54ccc1815c6dff04b0cbebe6491c6ec5d2ebdf8da6345c2a05d53dfd57c1137a257d548715be74fff7f3de63cf09240c3e06e010abadece476888af006aa044e01524742ec3dd66d29ec450422adc3dcb3923360fcfd9788216b5c142474b3ea12df7b334e3bd1d7dbec20f7d96f13d6d2aecae3ff211725344bb91dbc721183a8ecf1d627c800c9f47cf3170de2c45b6840dc34344e45d5c0c19c70c0b6483bb2fea532e8a51cae60eb2ae8d78c32b1c6a4169eec533833a8e722b90706d4d54529e20db47e303135a23128b2f41008e237fa09c89e3d1101294f2e9f1f2d112700a749f7f99f723b641a2ccfde0ab07d99816bbad84f57e06c34c59e2f577f2966c42fe4a6d06788bdb70b582b61207a2f360524ab41e08301f64fdf5bd39ab496f2e69de464a8f787d9f0e2b2c07316ec15c981f64eb8dc3714a82333b55dd7f0a9baa2b21287552708e52d62de9e7a0b405ca89a1d245ef35ccd8e312bb7246cda1a1ffd9d8ed7ce1827c623a744438ec78a78bc5989ba43b0915a68c0773c969a3a1055eb4c407cb01cecc97ae48248f4a58624908cb113a7bf8d012db3decce016297bcbfacec6860a0a6ce77964944eb2b8b875399f946bc718153fe478d61ceaabbe147a8fdedb5c7888e3cd6575c5f6c5152eca64bc8adcc5bd4ba21e161dc07684de8dcfbe51795715053da9f82b963db2c8b986a60336616df7b3d8173a49470090d37e40f8e8fc758f5d303ed8fd0ba15af22fcfbd6227891230ca382fe524f552d0f4b82ea0eb81fd0069537f5bbc27823e7938333358aa2cbd8c5e198e3f717a080c181d55d37d1af0791d31b86b0ce4f486cefe78bf47eabc4b50337188cd0f272f4188ffde2e78908d8ca9ae1e5cc801e6fbfd0c74e93b90ce7f6dfd1c64dd5e4eebb1de6c8c8cfe06b6ee61cfd28cf44a4d15c1e30b7d71793c2215c05396085f30c8978ef843d48334ee474d7e4cd7dfb781a4be276fc8160de1ba35ef29f071b1bf9041a816656a9d3b163bfe8f3873d6a0771f4c2cabf03d38479a8c7225d6af8d39b2a8c653e1524f0ea1ff8b792c47b5417e7a3f1d5ec73c64ae5b9d2b6ed7866bc75a9af8875daa7dc103064a3dc8354dc6b7997d699357c3cbee7ac90432a80fbfbb2db4b2eb8f2a0d7ece1c780c282741c1a2ce8203c168d75054c04b011faa61a7a240884246e151a02e0818e264270a555eab31e5e0b71eb355dc68e938b8f3a96175249776b81b52ec30aadec20ba0a28f39428534f18aaba7e8cffab524ade07874343fce7315f2658fb3b60ef431bc334940624cacf2aa71787d47b725afee4e28e8d55ef6222a4b23ab5853770e33ae89fadec658324ccb010c0f3f46f7337d82fb52572e88018cb896dc3ba361bf0b1bc32375fef24116e67d92eeabb0d12ee4535c83fa925154cedfe0c511fe2b57e41e502bc118fa28fd2719c4b27181297103bc15b10572cc08dc0a063b0dc469995481ff662e37df0ac5e11836744227963cccd0b63dd7d981f48699c82384590c2746fa7ab354236fb559288da43920653034d655b5879cc668e42a93d85d84321d72539332e64cb7c10ec2ff6e2fc50a5490d3f042f0ef0caded306eb6d4096d6217f36c5f0beaa6044eb5fefdecab524c1a7ffa94ca88baedb1bbd5f380ff31d1379fa22cb6a4d586a7d3a51af62f60fdb3813e12967c9e303b720063cb1e3c0b95782472f5b7cccfbdca71f04ae6dc9d1fdad0ae704811ff51e9e5a09f3180eb8804dcab2ebc1a03c7d340cfd1bdd1f7b61548c881010386d0563cf6d3d2ffaaa21650672c0e08a5e18089ad293d43c13afb5f5db498bbcb4ed60d952f427dd2dc4254b8d11ec2bd19b1f60ebc532760f8a67643fa2b3d90cb4e472fce15ba495d56dca7828b6ae844f508eeda209793692c6799cb1fddb13281d5cdf53f5e93ba21010e670c09a061b04cd72351482bfaa12adea1b505aa3d0086b1041f2555c349e6bfc7e92f1f64d3cbc1567d8ce20bb734ba09d61f96366f5a957f254e0e4ce5d94529dbb6590813a9c8c4d9ddaa55a09a25ce91b167208fd05892de4f11ab169d67fb38896549d22a8a1f91d9ee042d6df31b4bd0c6f827b25e0e82f9e0fc178e64bb983a95bd4f5b3e8b6d00bc2aa4da0588d4cca02acf6e68a1047a045abd242fa7f7708011f22b870d67ab8c3a50ea4d76361e3d7a904fbe1634186c1b10aed49fb43db16be884e80254998a65c6d508b5c8a7385c9d3daed6fec6e0b05ed7f2dd732999e1c2d17b765b0e39ff953eff2f3bde568745319e8af527286185ccc0a09130ce1f5630d1a11559150e33740a3a4fb40daee9e15c1a94a3f027b53e2d94230f5d12fc9698e2bc284c29192bfeca2cae8c66deaa50959413c1d5d50202991cfe984a63a21e2000df46eb66ccc7f8c1712cc7d61d65002959cba297290be44dbac9afaf0a864a1a6ce9f67d8f87a41b29cce5c4052e55cd03f1916a05b25315d68f86ea8574141a7ccbbce4b3377fe3af9a7a4a49faa141a24ce9609711df92794ab5b000163282088cade2053122ddcd8ecc35d6123b8b1022e1bd336f7b544399c8ade993c8266fd7abc2db28e89ee7c652d4f4227dfe5896990ebf19ee3ef8a161723cd3c866e2c1b032ed7f55169145ebea5205d1a4392cd232887ac19f0f61e6289eb02da11b88a79581ca46e73911d591b4f38f2b401c00dfa99d51a12180be32a36d4279680c5cb31ba3233496662376d304eb9146170d50084937b57d6353aaf01e6c70c682fd4f14f829d37ecda67a64bd9a8c77a00845d22b5bc1b8b8291a120a5c8106f33cfc50f6310797f88f1397110de5efb11e48f4f60b7538f40f25aa73e49343016c1af2b6ed3c52873069aed1c86bf10cec843e25ed555f12030c37564c4861cd25fb1457d32f242cec51a69b36d0ab78e30af24bd914afa5348becc85a5e93f2d8df3dc917d96a312b3b72027ffa18ed7131d4bdcf6996a0d22546da0839b4b1f76aeb67720133096a6a90ad0235f7791ef0b9e4b9d3f36985856eb09df291db1ff8f4ada47402086799845395a62f297113b970b2c5af244c49b388967f11c140a069c4df919aa6b98cd9221ed828e767930dfaf22e10afec89bf8af814ef09045aa114ba2c3a6fac7a4bc59c1a953fd9e0532bf30ab662ccc901242eff06306b85f6772757152fc044b0f998b23c40d28fb73e65ec476773e20695b60a24dc00b16d56d0e2ca3b9733ebb00177d59083bc0ac57136cbec293b994be4e217cf4459d08db95c9f1af8c273c8a70ed52061e4a04016de3444af6fcb35539d04457198d1d6644f70fb408c287a28b6e6ebae20b06ed193583cc5faeaa0d6e7bc306514abe19a6390a8eb8d36208675e1753b97fc63eead71d3ebafc95af407edbc60a120ed8b7a743f3874ce4929da0507651853d996eccc5bf2d9d92e44766f108f0a4fbb2dfcaff809c9fb812f7da46dfd87617343c18141e4724890efb8f16c0ddb48a1c29740c6ee18a81ebf1f56f0b8919c6a58fe49aeee809f16dbf0f75fa161918d9aec12eba3ca5423c3013c93c7f9928203aea28818e6ccf4aace8535fdbdcd32da1f0067a540dbcdd7114535f19669168fe34d849637666ff2e664a5c49b35d6e13ad1763e10877c90cecf1e86db1154394cbf65d67148a23b7deb00463bad3cb29484e29d1458471be050018efed443037df451b7807be6e62c9e277e26455b398a9ed6ed3e9e5845a96084f6bc0e983a25ede3a5117ac2ad69c0588cc07ed8a9f05e8a1b0e48385cd2b41c9a216caca77bcbe6752ab6a5b4f0dddebccf5803714a71a96eb40d90ed469c289b017c94a419050fe89866af8956a4a3667a374908c605a9df99862f9757c7495b640c0070f0d5e04112f04c4936d456b0e750a259190a64919ae62b5dc309a772398b4a25c1974f3658418705e31168af885544b3b47506f27d1b73a6eaab94d5a68a447f9b312161c2848ca702ac6c10dc30e31cbf2ca7e4f5c8cd9cc8e2a7cedee9f35f0bf65796ff24e28558f87dd5ab05534e9ce2954ad65c83fac31a4a1a96ec55b195feda239014fa0ab9caaedcf5d9026b69ac612941e3be5455b6285805f7bcfda3256851742e906d0658caf2153d866160d2749b9d6247c82f5dfcffc60f0d6c5b5d8fc589936ba4b504d89bf54efba9539035ca1d7b516626823d5fe0b2393e8d7dda62e24b3d330e07f3251d295ec73b72742187c90dafd5b9d87b8dfb93e77f58c4a51519754391e0660cd891761516ca82e28086b1d364d5025af7a50f59cde10dfaafc70303a8cb58786ddb451196e021cf948870f661d556d1c306a4c870fbd48b05eb03c98cac2ba751741db3e7eae965343440107a6297dd3325c997b362e13bd3d2a5e6d84af60d43c4ef99901220a899aa4c9e6c304cb7c39e65ac1f1b7e0aea00c2ff9a2d0691ca1d26c1e27c7cd03488e017138b5004be6145e2416beda77bd3d6dd9bd67cc16206691d02fed0a65857953413410f49c96a795250dc2186dd2007f06ce6dfdca440b31f03a99d8b6fa27703a0dc278630379f740b7d3e38427bcc788751ba3ca8dbd4e1b90af1309edeeb91c53c6890d31905924acdaf9e92f7a30fc8d69a2d512041539c06c03df366f1ce27b1a4472e5aca5db98be09fda3a687a07639b8465bde046431853f59b79bef7dec4c1d23fda71ebcf7c4194d2688b48e721982fa2abafb52f485b88ce366674ab4e05eb2933ff644cb338a6611fee684fcc8bdf5098c86668694a0a5f1b97f63a7754c87d2b766d7d96f025d4af6d8b7fbabbc3ceeddda4e93283b08622b7b9b78b1743ae5acff025ce24dc2b96897d15b580afb7829d73b8f75270855de5ee33c000d5e97c3c2e1c8e172e193f0304611e25608ce5aa53410d8b4290e453cd547325bd9c0773e3aa71ab848a4e5a20375f2a0a70056b3286f41e066e321e9d1cb41936a5d884fa2e52bac9454fb32b3b25cedc46d1f864280d16d719bd37e0b44d7f24eb0dd0e60c5674582fc839774f0f12a51d58395372a30e8bd27988dc8b185920b0a7b31d162994a99bf10fd261ce588a7a79dace13cd789bb72f4b162dea9926f9bc72355b8ad6e11c5377bcb022a1c5bf02b169f2d221cfaca92a7c9ee3d0e1e6938db6511a0dcb9a31a2853dd19f9c572ff8c0d0d2ab25ae13959aaaa8d5d7a02d175a1626cd8aee99976125ca44287a9254825b52dc8f6ac4701ad87c9249c80ea48652d4a5eb56d4bc4b4b7620e1e2e93502ecfae59b10765fdb18583079f7b2741802dafdf9d5c4b9d23065ae6be9d8b9ae2ffba02857deb88ab0ae06d2220faf17f8ddedb931b0112f7410da70d77ba71aa6735e8efdaaecaf0211c2d1fa636f055cc22d35ddc0c1ad8d2c5d037e8a1905f494d14cd27a591c4f15e7fec694ab6bebd870791734ac29ab14b511583571b215313da94dd9e3ff330282eea436db347669a95431de9ee160b37bf4c3b5e352ead09a115a90e36c7dd5c6ad1894e66c16bf4e3ccfe42b46252bf4208efdd4e97574fed5906ec17e1d2af26da7fa69d7931257b763687ff38927e1f10ef7b6203899d556979350eb3b8924ba658e939eb06b67c26b4ea8efb612d12050d22af790a438dc498edcb13999d56f0d429f5fa1344d8cf6d165de78fcb7986dbe672fa5921c90c38c5abe750b871b1f5a3b2966a9b8a6e9ef3fe624bf61277ac7ee7ea663363204e5983e492aeaca317ddce691ed451ac34a5765f87987b4f3170900d23db1fd8843aa889590a5b84fc2347f5226fd5c01248793e29439ed96410ff92bde2b9c045ae7812ff9fce5fc7d0daa6ddbe4ce28fa7b4fa6d98db1d330222489bf9dfb6501ea7af6bc7c8cc99829794511c87382ae11228a832f682dfd38b7c90bb3203cfc1df493298caaba8203a0cc1f5ab4a9dda2df563f094fa2880c34f4912f5e598c07d2c097b7a0b65d6826acbcd960079222f4fece95817835a295e037c8eab7424d8d09c324f1ea9a88bd7bf717fade9b29c09536466c044b4fa10864434c9a82b0d0e1af88a0fe2bb81133a2f79393297a5b681f9d4684bc89d10f2119b890b7f56d8c8e43eb471a61b66dd0ce65b6d0ce915cf15364b5af4c1346782270c8d297e7eaba18e2eb263934aa25455c8c41a9f42b1a5af23e1d7d8414f76cb32d3cd77ce5481dd3a9177565e09d5feb6450ea3f3cd4c6ae2fbebe0b118c1982000f31840e07786c44d0a1dd845e41cf854bcf3c7dfa2b443f40c5e6d44e9c64804573ec18caf2bc1f8e609f74174304f4ce15dacb3ed23a20f4110dd3e99d4e62f4f78ae3fc627365884db0271047652a5a9a2039cab21d56ab33306b67ef10818a97956fd43b9502e73010c019c636eaf1917535b14d3c5e58e1b6c7e3550233587a712a856cccbb6031217516211e430d8e7a6c59c88ef91a54ee315f8a5bef07a72ddf5f60a42a6c0f419e3f2dd95313461600998ca42df0814b1a9823b0a97fa4b97c82dbff6231718da1063136eeb605a1675dadaf541f60696440516fcceff5bb1dd25dd7c49fe1f33af615ed7d048bcbf179e75a79fcbc5e70052497521a41e52be6a5a863d2d070bb8da51cd2a52becbbb72f4ede3377573c01edb96fe2691cad8b202f02da190a33472dc5c438aefe3538ba6e79d51bea53bbeadc91449c6bbc05a8ab81f1ab37ad5a6982db75ea675c5b4248a3427d68969aba8eedc7e3c93cb5baa4db7435781dec7b538d17359fdb9b3c2435f4b50cf36086b579f95dd9d3cb7b4cde5ec72229abe66a4330403e9e0adc90862251ac758190aaa4ada0ea27bc48f1cff528ec08e121adb600d8aeb9034b9f38a7a8de1624053acb3cd00acc9188133b04b6ea0c882c3b544e8f5985d9d3ec799d5573693924bfd7a2c57908eb233e9af130da238a15795e981b22b9a2bec39d116a869fc61e7473560c6ff789ab2347627d92c2ca3a15a1245230d7391167098e43701e89d2362d60c6a1395af22758484d374b8eead9ecd511b62394d6f0d9346ad9ecd767172ebf8556b3ec3d3e993601f0cb1698803995ee23a3c991c023c8c83363658f9a178703309e911eceec6d1e395efd30b5050bb2f3332171cd9d91fa11758f699a3dd223c3747a7b35efee717f075ade71d0a315fa20660afc99300d015dd0b1d71aa96aa6ceb5d874f0593545fd91ef4a37fead9c63b18a720793612d852a8660a0b60a78d0d76feb237dd9084043d5474f40286115d437944c874fb7061e54e55da6777a0087f85be9830132a2c41e46157daecc130959960255134c058c5a909c217eb0cbdf3a612024aa4a7808709605574500069eb5ccd59b2cb3baa26e35950ea26277e7de00a2a3dbdfb033a99b2227ef266247a0b7ec9f8b3cf726c7723ee0312dc413495eff18b4eb7a43f6e0e825093e9af51040d4c38732b543ef33c983c7c2ed8fd0d7561202946fe87d3eac282e0302be7bf5b67aa2d787f92e449159ee3b2d10bebfbc360a2378877c474f67d7039f6d551526472de49719c7adafa63fea3fc63d9ac8acfa5be981b69042fe0f54321faa0e72cb19c341a4353c6e3a12886df1fa0b204987f7a38b0d1a68a53752bf43f89fe00774fce599de56856f9a6864552ee83610e3aaf751db4abdc96539b36fdc530dcc7a88756933421e956f0ed0f5fac12c7dd28c8a172f4166bd317ea17293b3c1762e096b2affd444edfddfa7d3f3b47fad4338be0a10260d9ae9e15481a813010ddcd72db19c21c50b29a5c1259a5708016e23204b739a8ea5b4b58ff5301496f315b6978b45084cd8b207762df2e08a971eb838d84ad10a3896d0b0b959a7bee8029cdd7369e98eaa2564e7f011ba72298c505697cfa85ddd601a1fa57db7d91f5613c8dafa375907f019cc2cf04da938a45a47a2c83db21ddddeef6be3137cb9b9a05390781ed3fc7913a42f5d747b47d9d38060d9087cf85ad0049448e9f49940b841f6fd5896edf4f08017aeafb8f9706a347aaa71cb7e772c71564d5791911389d00e6eeb7f12c080e712c7ba00faf9ecea480a71ccff796f8aec99afa2a543b581d4162a6265b945e9de8b95306087928267fb80baa4be46c547ff0a45baf67e48f55a7018d3c21d8a3ed65d10d2c59802db31baa349da1413aa0a90692bc2adcfed4f75fafdf3ad8e6b93ac89dfbffd1302af35f24d3bb91fc673abda593a2428806b22f9279dfbc55e5d4eca2ce50f6384cf3cd52326c8afbd9dd9779e9d2f242e260f498d92164994c8e987e6527388fed0dee82943da45b9b3ee3ab65ac05541b20bc46659e1d5d84ffd17f536b0c4f8a4b9df7126719721891b4274b442790c4b56b73534a75d52eee75fff79c57fc2fab7e149636bd6a5966fb81e59bc29e75c27d2dea4152eae8a48e9ca85d0d8277488be69cb90719c6bdb90963941d567052e019fd50837e5c616758718ced223cc80ee91c3bd779d8248c40196c5e750dc80a0c1b307ae7921970915b515f00bfc88a387c2dfcca5b44f6fb79c64fb94464813b98d048defb80dfa590db49ee381ebe5197c52c900f97ff53b072557b6258c1bbbc7cc08df62988694455b61aadb32b1bc498b8e9fbe57471e28f8e456b725dcd649d8dc65d4066ed4dcc2fcd1913c7aeb6df0d00740a05bf00bb0b892dc8b7f6af01e362ea5f5949b21c9da1128c6d550550bf60ba3707c0912d0e8d209ac2fdf7b601ff22070ca11c7264af19ecfb3ce601378c7bc8b4bf49e1f893cf9c1448580ad407330c98d03f5873e35db87b33dae32a6a584a22ff5a3ac085952b224439308001038819a6230da05986fd089644014708191f241b910ea759514fb26c6e69c257f90fb764690e37a06628c52edd3f6ded30da89971a7d871c9f25f87d77db7e93588a50b53d4dae6231f1bbdc56c00e96a22e596960168b97dd53c4d05b199352d5d4a4361cc5908f747d854b7532f2a9660d76ca3985986f1b6c44ec2775c8cf40a98cf8a9ef46caabfeb4a7496a975093d653950ac53e464ac79ea9dfb25ef9692452e73417be11d959112f0ea31d19ce80f630daa117a3e29d6a8fe7af684aa74fb8ab60e287df724af947af7dce6bb2c0e2049de120a54e39312c8841bbb5e9fc8ab2334aeb3744b5e87716cf6509c355e8802a1044b0af6765ca50f459257de644b5f63407682ec52d85574a4004092feef27459ffd7656140a6a1a66ad103cf891c4726d0d838dc106e1f9e4ee89c91598de2ad8a6cf145d9ad1adc356a56d2064eaf139af49ba8aaff1ca53a6c89f979a9bfb4399776c77ca8b1aac986c2677cae029ea8a8fa2d12bb2437bd7ec06bb9ec84bb7038917562f7f9af253c057d7849865d0335aec3cb691c5aa87adac2b64da6ac54ae10d6db7dc7cf0175c74737ec459a620e81cdb0c72e4b738a4ad1c0a9f2bd4c5466d4d9560d9ab7c8c3b58e3bce878854b0c36ad0ccbd53ce860ffea88c3e133c33fc832f9cad72e2f70b15ec3c47cda3e60ee28c604f7f4cfaca43d1fce6c72a8b916141535aa7734409661c573c');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('198485882', 131072);
SELECT pg_catalog.lowrite(0, '\xc888f353d096d359f050be81121ef57c30f94077d81af586565c0bcab0e5c2ef356654ae4f8c4efefffd5edea02a7f40044cf6b347913961a050d9239546e5eb18b52a01f381e058efa218a675a877223b34c1200b373eba02bf50b868fb4ef4db971040a219ba4420b826334f9ceb987592a1ee1338c50d16b3a590e3');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('198485883', 131072);
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('198485884', 131072);
SELECT pg_catalog.lowrite(0, '\x6ca9df9f2e98068d369e8148');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('198485885', 131072);
SELECT pg_catalog.lowrite(0, '\xe8c9d2f86d05deb380d479aa8a3886f3900f0a32904972ab18cef6a3412af6080bd78f71a492a6200fa8250501ef5c21cd11efe2bbce05ed55f5c858f28493da693dc613eb8d0f2fc426b24e6a5cb56c87');
SELECT pg_catalog.lo_close(0);

COMMIT;
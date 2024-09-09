import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/exchange_rate_repository/github_exchange_rate_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

class MockClient extends Mock implements Client {}

final primaryUri = Uri.parse(
  "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.min.json",
);

final secondaryUri = Uri.parse(
  "https://latest.currency-api.pages.dev/v1/currencies/eur.min.json",
);

void main() {
  final client = MockClient();

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  tearDown(() {
    reset(client);
  });

  group("Github Exchange Rate Repository", () {
    test("gets primary exchange rate", () async {
      when(() => client.get(primaryUri)).thenAnswer((_) => Future.value(Response(primaryData, 200)));

      final repository = GithubExchangeRateRepository(client: client);
      final snapshot = await repository.getExchangeRateSnapshot(CurrencyCode.EUR);

      expect(snapshot.baseCode, CurrencyCode.EUR);
      expect(snapshot.exchangeRates[CurrencyCode.USD], 1.108713);
      expect(snapshot.exchangeRates[CurrencyCode.KRW], 1482.80751734);
      expect(snapshot.exchangeRates[CurrencyCode.MXN], 22.15095684);

      repository.dispose();
    });

    test("gets secondary exchange rate if primary fails due to error", () async {
      when(() => client.get(primaryUri)).thenThrow(StateError("test error"));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(secondaryData, 200)));

      final repository = GithubExchangeRateRepository(client: client);
      final snapshot = await repository.getExchangeRateSnapshot(CurrencyCode.EUR);

      expect(snapshot.baseCode, CurrencyCode.EUR);
      expect(snapshot.exchangeRates[CurrencyCode.USD], 2.108713);
      expect(snapshot.exchangeRates[CurrencyCode.KRW], 2482.80751734);
      expect(snapshot.exchangeRates[CurrencyCode.MXN], 32.15095684);

      repository.dispose();
    });

    test("gets secondary exchange rate if primary fails due to status code", () async {
      when(() => client.get(primaryUri)).thenAnswer((_) => Future.value(Response(primaryData, 404)));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(secondaryData, 200)));

      final repository = GithubExchangeRateRepository(client: client);
      final snapshot = await repository.getExchangeRateSnapshot(CurrencyCode.EUR);

      expect(snapshot.baseCode, CurrencyCode.EUR);
      expect(snapshot.exchangeRates[CurrencyCode.USD], 2.108713);
      expect(snapshot.exchangeRates[CurrencyCode.KRW], 2482.80751734);
      expect(snapshot.exchangeRates[CurrencyCode.MXN], 32.15095684);

      repository.dispose();
    });

    test("gets secondary exchange rate if primary fails due to malformed data", () async {
      when(() => client.get(primaryUri)).thenAnswer((_) => Future.value(Response(malformedData, 200)));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(secondaryData, 200)));

      final repository = GithubExchangeRateRepository(client: client);
      final snapshot = await repository.getExchangeRateSnapshot(CurrencyCode.EUR);

      expect(snapshot.baseCode, CurrencyCode.EUR);
      expect(snapshot.exchangeRates[CurrencyCode.USD], 2.108713);
      expect(snapshot.exchangeRates[CurrencyCode.KRW], 2482.80751734);
      expect(snapshot.exchangeRates[CurrencyCode.MXN], 32.15095684);

      repository.dispose();
    });

    test("gets secondary exchange rate if primary fails due to missing data", () async {
      when(() => client.get(primaryUri)).thenAnswer((_) => Future.value(Response(missingData, 200)));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(secondaryData, 200)));

      final repository = GithubExchangeRateRepository(client: client);
      final snapshot = await repository.getExchangeRateSnapshot(CurrencyCode.EUR);

      expect(snapshot.baseCode, CurrencyCode.EUR);
      expect(snapshot.exchangeRates[CurrencyCode.USD], 2.108713);
      expect(snapshot.exchangeRates[CurrencyCode.KRW], 2482.80751734);
      expect(snapshot.exchangeRates[CurrencyCode.MXN], 32.15095684);

      repository.dispose();
    });

    test("throws if secondary exchange rate fails due to error", () async {
      when(() => client.get(primaryUri)).thenThrow(StateError("test error"));
      when(() => client.get(secondaryUri)).thenThrow(StateError("test error"));

      final repository = GithubExchangeRateRepository(client: client);

      expect(
        () async => repository.getExchangeRateSnapshot(CurrencyCode.EUR),
        throwsA(HasErrorCode(ErrorCode.repository_exchangeRate_httpError)),
      );

      repository.dispose();
    });

    test("throws if secondary exchange rate fails due to status code", () async {
      when(() => client.get(primaryUri)).thenThrow(StateError("test error"));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(secondaryData, 404)));

      final repository = GithubExchangeRateRepository(client: client);

      expect(
        () => repository.getExchangeRateSnapshot(CurrencyCode.EUR),
        throwsA(HasErrorCode(ErrorCode.repository_exchangeRate_httpError)),
      );

      repository.dispose();
    });

    test("throws if secondary exchange rate fails due to malformed data", () async {
      when(() => client.get(primaryUri)).thenThrow(StateError("test error"));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(malformedData, 200)));

      final repository = GithubExchangeRateRepository(client: client);

      expect(
        () async => repository.getExchangeRateSnapshot(CurrencyCode.EUR),
        throwsA(HasErrorCode(ErrorCode.repository_exchangeRate_parsingError)),
      );

      repository.dispose();
    });

    test("throws if secondary exchange rate fails due to missing data", () async {
      when(() => client.get(primaryUri)).thenThrow(StateError("test error"));
      when(() => client.get(secondaryUri)).thenAnswer((_) => Future.value(Response(missingData, 200)));

      final repository = GithubExchangeRateRepository(client: client);

      expect(
        () async => repository.getExchangeRateSnapshot(CurrencyCode.EUR),
        throwsA(HasErrorCode(ErrorCode.repository_exchangeRate_parsingError)),
      );

      repository.dispose();
    });
  });
}

const primaryData =
    """{"date":"2024-09-08","eur":{"1000sats":3324.81413663,"1inch":4.41963061,"aave":0.008740758,"ada":3.36382628,"aed":4.07174848,"afn":77.88217445,"agix":2.3744766,"akt":0.48717834,"algo":9.13513745,"all":99.47451566,"amd":428.21601039,"amp":308.64917532,"ang":1.98182515,"aoa":1020.36765074,"ape":1.51028953,"apt":0.19004581,"ar":0.056114646,"arb":2.21929311,"ars":1059.93332826,"atom":0.30195945,"ats":13.7603,"aud":1.66227405,"avax":0.050650683,"awg":1.98459626,"axs":0.25987574,"azm":9424.05917757,"azn":1.88481184,"bake":4.7594085,"bam":1.95583,"bat":7.10758274,"bbd":2.21742599,"bch":0.003671689,"bdt":133.05100668,"bef":40.3399,"bgn":1.95583,"bhd":0.41687609,"bif":3194.41774245,"bmd":1.108713,"bnb":0.0022464158,"bnd":1.44430507,"bob":7.6779598,"brl":6.19863046,"bsd":1.108713,"bsv":0.025037012,"bsw":14.87693162,"btc":0.000020443781,"btcb":4.61249967,"btg":0.054115387,"btn":93.12051455,"btt":1413869.58372996,"busd":1.10907628,"bwp":14.7823369,"byn":3.63103621,"byr":36310.3620551,"bzd":2.23427517,"cad":1.50511573,"cake":0.69238181,"cdf":3135.35156853,"celo":2.72943603,"cfx":8.70114942,"chf":0.93463164,"chz":21.95510581,"clp":1046.76964048,"cnh":7.86554289,"cny":7.85816718,"comp":0.026868419,"cop":4628.27853811,"crc":580.77620392,"cro":14.562696,"crv":4.25717867,"cspr":99.32610332,"cuc":1.108713,"cup":26.51525378,"cve":110.27000001,"cvx":0.52802737,"cyp":0.585274,"czk":25.04342026,"dai":1.10915021,"dash":0.047049753,"dcr":0.099895889,"dem":1.95583,"dfi":54.90757154,"djf":198.09911843,"dkk":7.46421522,"doge":11.56087726,"dop":66.31112579,"dot":0.26967552,"dydx":1.27415976,"dzd":147.30046343,"eek":15.64664,"egld":0.045323268,"egp":53.71292521,"enj":8.31461433,"eos":2.39495631,"ern":16.63069494,"esp":166.38600001,"etb":122.98964355,"etc":0.06275404,"eth":0.00048680993,"eur":1,"fei":1.1122571,"fil":0.3283682,"fim":5.94573,"fjd":2.46012144,"fkp":0.84430755,"flow":2.14168316,"flr":76.51502607,"frax":1.11232892,"frf":6.55957,"ftm":2.85542835,"ftt":0.88523104,"fxs":0.63379694,"gala":60.367114,"gbp":0.84430755,"gel":2.9863185,"ggp":0.84430755,"ghc":173211.68869814,"ghs":17.32116887,"gip":0.84430755,"gmd":77.60913286,"gmx":0.049021128,"gnf":9567.56028612,"gno":0.0077537794,"grd":340.75000002,"grt":8.3539066,"gt":0.15250464,"gtq":8.5738218,"gusd":1.10779808,"gyd":231.70368136,"hbar":22.92925243,"hkd":8.64311655,"hnl":27.47606418,"hnt":0.13861976,"hot":747.95676281,"hrk":7.5345,"ht":3.93329637,"htg":148.14500948,"huf":393.66192421,"icp":0.15565585,"idr":17056.6562305,"iep":0.787564,"ils":4.13074224,"imp":0.84430755,"imx":0.93922831,"inj":0.068890817,"inr":93.12051455,"iqd":1452.87844845,"irr":46568.86252908,"isk":153.07557917,"itl":1936.27000009,"jep":0.84430755,"jmd":174.60448186,"jod":0.78607751,"jpy":157.79956532,"kas":7.47161025,"kava":3.94118423,"kcs":0.14240359,"kda":2.29390068,"kes":142.34124043,"kgs":93.35363096,"khr":4508.72278507,"klay":8.80897878,"kmf":491.96775002,"knc":2.71916281,"kpw":997.84169624,"krw":1482.80751734,"ksm":0.062503351,"kwd":0.3397102,"kyd":0.90914917,"kzt":531.24309414,"lak":24591.33283599,"lbp":100309.90063184,"ldo":1.20924731,"leo":0.20297907,"link":0.11030558,"lkr":331.27811458,"lrc":9.46135763,"lrd":216.42100759,"lsl":19.79462126,"ltc":0.01787578,"ltl":3.4528,"luf":40.3399,"luna":3.42073209,"lunc":14758.9226416,"lvl":0.7028,"lyd":5.27680904,"mad":10.78930395,"mana":4.35509447,"matic":2.99807566,"mbx":3.01462758,"mdl":19.25834428,"mga":5037.60559405,"mgf":25188.02797024,"mina":2.76223212,"mkd":61.38944298,"mkr":0.00071517163,"mmk":2323.90026362,"mnt":3755.10080541,"mop":8.90241005,"mro":441.38244287,"mru":44.13824429,"mtl":0.4293,"mur":50.93351675,"mvr":17.14070195,"mwk":1921.71554437,"mxn":22.15095684,"mxv":2.66168158,"myr":4.80156768,"mzm":70588.24927748,"mzn":70.58824928,"nad":19.79462126,"near":0.30196295,"neo":0.12172266,"nexo":1.19391105,"nft":2450710.78902993,"ngn":1789.41488349,"nio":40.60583601,"nlg":2.20371,"nok":11.88204672,"npr":149.06266366,"nzd":1.79608608,"okb":0.031068667,"omr":0.4269685,"one":103.71962713,"op":0.77960358,"ordi":0.038712373,"pab":1.108713,"paxg":0.00044471837,"pen":4.21225845,"pepe":163706.6439438,"pgk":4.32920549,"php":62.28910075,"pkr":308.82253141,"pln":4.28277014,"pte":200.48200001,"pyg":8594.34539409,"qar":4.0357153,"qnt":0.018241245,"qtum":0.52573178,"rol":49718.4182033,"ron":4.97184182,"rpl":0.12313022,"rsd":116.67032956,"rub":100.13709585,"rune":0.31488658,"rvn":69.51765832,"rwf":1478.00963697,"sand":4.61703678,"sar":4.15767373,"sbd":9.12529461,"scr":16.30523309,"sdd":66407.75599417,"sdg":664.07755994,"sek":11.42004055,"sgd":1.44430507,"shib":86020.24084289,"shp":0.84430755,"sit":239.64000001,"skk":30.126,"sle":25.03473164,"sll":25034.73164482,"snx":0.87246728,"sol":0.0086754832,"sos":633.15217716,"spl":0.1847855,"srd":31.98637107,"srg":31986.37106839,"std":24503.98232642,"stn":24.50398233,"stx":0.79230901,"sui":1.24488285,"svc":9.70123871,"syp":14415.46750307,"szl":19.79462126,"thb":37.35705101,"theta":0.98890773,"tjs":11.82858956,"tmm":19402.47722259,"tmt":3.88049544,"tnd":3.36382052,"ton":0.23607138,"top":2.56887385,"trl":37660136.11839834,"trx":7.30381992,"try":37.66013612,"ttd":7.52123417,"ttt":531.18220804,"tusd":1.11105964,"tvd":1.66227405,"twd":35.55395502,"twt":1.38070881,"tzs":3012.84557233,"uah":45.66759749,"ugx":4122.07389342,"uni":0.17146946,"usd":1.108713,"usdc":1.10910921,"usdd":1.11073425,"usdp":1.10763815,"usdt":1.1092054,"uyu":44.7652144,"uzs":14089.04920278,"val":1936.27000009,"veb":4063311170.562254,"ved":40.63310262,"vef":4063310.2616386,"ves":40.63310262,"vet":54.66166643,"vnd":27279.95020283,"vuv":130.1303211,"waves":1.15871268,"wemix":1.34496809,"woo":8.09162358,"wst":2.97401297,"xaf":655.95700003,"xag":0.039694639,"xau":0.0004439329,"xaut":0.00044412767,"xbt":0.000020443781,"xcd":2.99352515,"xch":0.086479493,"xdc":42.17162181,"xdr":0.82174975,"xec":37697.95855652,"xem":70.1664657,"xlm":12.43087957,"xmr":0.006586958,"xof":655.95700003,"xpd":0.0011549093,"xpf":119.33174225,"xpt":0.0012356235,"xrp":2.10261362,"xtz":1.82335464,"yer":277.36511674,"zar":19.79462126,"zec":0.040262665,"zil":87.00250176,"zmk":29269.38619739,"zmw":29.2693862,"zwd":401.24323319,"zwg":15.6218975,"zwl":39034.81333573}}""";

const secondaryData =
    """{"date":"2024-09-08","eur":{"1000sats":3324.81413663,"1inch":4.41963061,"aave":0.008740758,"ada":3.36382628,"aed":4.07174848,"afn":77.88217445,"agix":2.3744766,"akt":0.48717834,"algo":9.13513745,"all":99.47451566,"amd":428.21601039,"amp":308.64917532,"ang":1.98182515,"aoa":1020.36765074,"ape":1.51028953,"apt":0.19004581,"ar":0.056114646,"arb":2.21929311,"ars":1059.93332826,"atom":0.30195945,"ats":13.7603,"aud":1.66227405,"avax":0.050650683,"awg":1.98459626,"axs":0.25987574,"azm":9424.05917757,"azn":1.88481184,"bake":4.7594085,"bam":1.95583,"bat":7.10758274,"bbd":2.21742599,"bch":0.003671689,"bdt":133.05100668,"bef":40.3399,"bgn":1.95583,"bhd":0.41687609,"bif":3194.41774245,"bmd":1.108713,"bnb":0.0022464158,"bnd":1.44430507,"bob":7.6779598,"brl":6.19863046,"bsd":1.108713,"bsv":0.025037012,"bsw":14.87693162,"btc":0.000020443781,"btcb":4.61249967,"btg":0.054115387,"btn":93.12051455,"btt":1413869.58372996,"busd":1.10907628,"bwp":14.7823369,"byn":3.63103621,"byr":36310.3620551,"bzd":2.23427517,"cad":1.50511573,"cake":0.69238181,"cdf":3135.35156853,"celo":2.72943603,"cfx":8.70114942,"chf":0.93463164,"chz":21.95510581,"clp":1046.76964048,"cnh":7.86554289,"cny":7.85816718,"comp":0.026868419,"cop":4628.27853811,"crc":580.77620392,"cro":14.562696,"crv":4.25717867,"cspr":99.32610332,"cuc":1.108713,"cup":26.51525378,"cve":110.27000001,"cvx":0.52802737,"cyp":0.585274,"czk":25.04342026,"dai":1.10915021,"dash":0.047049753,"dcr":0.099895889,"dem":1.95583,"dfi":54.90757154,"djf":198.09911843,"dkk":7.46421522,"doge":11.56087726,"dop":66.31112579,"dot":0.26967552,"dydx":1.27415976,"dzd":147.30046343,"eek":15.64664,"egld":0.045323268,"egp":53.71292521,"enj":8.31461433,"eos":2.39495631,"ern":16.63069494,"esp":166.38600001,"etb":122.98964355,"etc":0.06275404,"eth":0.00048680993,"eur":1,"fei":1.1122571,"fil":0.3283682,"fim":5.94573,"fjd":2.46012144,"fkp":0.84430755,"flow":2.14168316,"flr":76.51502607,"frax":1.11232892,"frf":6.55957,"ftm":2.85542835,"ftt":0.88523104,"fxs":0.63379694,"gala":60.367114,"gbp":0.84430755,"gel":2.9863185,"ggp":0.84430755,"ghc":173211.68869814,"ghs":17.32116887,"gip":0.84430755,"gmd":77.60913286,"gmx":0.049021128,"gnf":9567.56028612,"gno":0.0077537794,"grd":340.75000002,"grt":8.3539066,"gt":0.15250464,"gtq":8.5738218,"gusd":1.10779808,"gyd":231.70368136,"hbar":22.92925243,"hkd":8.64311655,"hnl":27.47606418,"hnt":0.13861976,"hot":747.95676281,"hrk":7.5345,"ht":3.93329637,"htg":148.14500948,"huf":393.66192421,"icp":0.15565585,"idr":17056.6562305,"iep":0.787564,"ils":4.13074224,"imp":0.84430755,"imx":0.93922831,"inj":0.068890817,"inr":93.12051455,"iqd":1452.87844845,"irr":46568.86252908,"isk":153.07557917,"itl":1936.27000009,"jep":0.84430755,"jmd":174.60448186,"jod":0.78607751,"jpy":157.79956532,"kas":7.47161025,"kava":3.94118423,"kcs":0.14240359,"kda":2.29390068,"kes":142.34124043,"kgs":93.35363096,"khr":4508.72278507,"klay":8.80897878,"kmf":491.96775002,"knc":2.71916281,"kpw":997.84169624,"krw":2482.80751734,"ksm":0.062503351,"kwd":0.3397102,"kyd":0.90914917,"kzt":531.24309414,"lak":24591.33283599,"lbp":100309.90063184,"ldo":1.20924731,"leo":0.20297907,"link":0.11030558,"lkr":331.27811458,"lrc":9.46135763,"lrd":216.42100759,"lsl":19.79462126,"ltc":0.01787578,"ltl":3.4528,"luf":40.3399,"luna":3.42073209,"lunc":14758.9226416,"lvl":0.7028,"lyd":5.27680904,"mad":10.78930395,"mana":4.35509447,"matic":2.99807566,"mbx":3.01462758,"mdl":19.25834428,"mga":5037.60559405,"mgf":25188.02797024,"mina":2.76223212,"mkd":61.38944298,"mkr":0.00071517163,"mmk":2323.90026362,"mnt":3755.10080541,"mop":8.90241005,"mro":441.38244287,"mru":44.13824429,"mtl":0.4293,"mur":50.93351675,"mvr":17.14070195,"mwk":1921.71554437,"mxn":32.15095684,"mxv":2.66168158,"myr":4.80156768,"mzm":70588.24927748,"mzn":70.58824928,"nad":19.79462126,"near":0.30196295,"neo":0.12172266,"nexo":1.19391105,"nft":2450710.78902993,"ngn":1789.41488349,"nio":40.60583601,"nlg":2.20371,"nok":11.88204672,"npr":149.06266366,"nzd":1.79608608,"okb":0.031068667,"omr":0.4269685,"one":103.71962713,"op":0.77960358,"ordi":0.038712373,"pab":1.108713,"paxg":0.00044471837,"pen":4.21225845,"pepe":163706.6439438,"pgk":4.32920549,"php":62.28910075,"pkr":308.82253141,"pln":4.28277014,"pte":200.48200001,"pyg":8594.34539409,"qar":4.0357153,"qnt":0.018241245,"qtum":0.52573178,"rol":49718.4182033,"ron":4.97184182,"rpl":0.12313022,"rsd":116.67032956,"rub":100.13709585,"rune":0.31488658,"rvn":69.51765832,"rwf":1478.00963697,"sand":4.61703678,"sar":4.15767373,"sbd":9.12529461,"scr":16.30523309,"sdd":66407.75599417,"sdg":664.07755994,"sek":11.42004055,"sgd":1.44430507,"shib":86020.24084289,"shp":0.84430755,"sit":239.64000001,"skk":30.126,"sle":25.03473164,"sll":25034.73164482,"snx":0.87246728,"sol":0.0086754832,"sos":633.15217716,"spl":0.1847855,"srd":31.98637107,"srg":31986.37106839,"std":24503.98232642,"stn":24.50398233,"stx":0.79230901,"sui":1.24488285,"svc":9.70123871,"syp":14415.46750307,"szl":19.79462126,"thb":37.35705101,"theta":0.98890773,"tjs":11.82858956,"tmm":19402.47722259,"tmt":3.88049544,"tnd":3.36382052,"ton":0.23607138,"top":2.56887385,"trl":37660136.11839834,"trx":7.30381992,"try":37.66013612,"ttd":7.52123417,"ttt":531.18220804,"tusd":1.11105964,"tvd":1.66227405,"twd":35.55395502,"twt":1.38070881,"tzs":3012.84557233,"uah":45.66759749,"ugx":4122.07389342,"uni":0.17146946,"usd":2.108713,"usdc":1.10910921,"usdd":1.11073425,"usdp":1.10763815,"usdt":1.1092054,"uyu":44.7652144,"uzs":14089.04920278,"val":1936.27000009,"veb":4063311170.562254,"ved":40.63310262,"vef":4063310.2616386,"ves":40.63310262,"vet":54.66166643,"vnd":27279.95020283,"vuv":130.1303211,"waves":1.15871268,"wemix":1.34496809,"woo":8.09162358,"wst":2.97401297,"xaf":655.95700003,"xag":0.039694639,"xau":0.0004439329,"xaut":0.00044412767,"xbt":0.000020443781,"xcd":2.99352515,"xch":0.086479493,"xdc":42.17162181,"xdr":0.82174975,"xec":37697.95855652,"xem":70.1664657,"xlm":12.43087957,"xmr":0.006586958,"xof":655.95700003,"xpd":0.0011549093,"xpf":119.33174225,"xpt":0.0012356235,"xrp":2.10261362,"xtz":1.82335464,"yer":277.36511674,"zar":19.79462126,"zec":0.040262665,"zil":87.00250176,"zmk":29269.38619739,"zmw":29.2693862,"zwd":401.24323319,"zwg":15.6218975,"zwl":39034.81333573}}""";

const malformedData =
    """"date":"2024-09-08","eur":{"1000sats":3324.81413663,"1inch":4.41963061,"aave":0.008740758,"ada":3.36382628,"aed":4.07174848,"afn":77.88217445,"agix":2.3744766,"akt":0.48717834,"algo":9.13513745,"all":99.47451566,"amd":428.21601039,"amp":308.64917532,"ang":1.98182515,"aoa":1020.36765074,"ape":1.51028953,"apt":0.19004581,"ar":0.056114646,"arb":2.21929311,"ars":1059.93332826,"atom":0.30195945,"ats":13.7603,"aud":1.66227405,"avax":0.050650683,"awg":1.98459626,"axs":0.25987574,"azm":9424.05917757,"azn":1.88481184,"bake":4.7594085,"bam":1.95583,"bat":7.10758274,"bbd":2.21742599,"bch":0.003671689,"bdt":133.05100668,"bef":40.3399,"bgn":1.95583,"bhd":0.41687609,"bif":3194.41774245,"bmd":1.108713,"bnb":0.0022464158,"bnd":1.44430507,"bob":7.6779598,"brl":6.19863046,"bsd":1.108713,"bsv":0.025037012,"bsw":14.87693162,"btc":0.000020443781,"btcb":4.61249967,"btg":0.054115387,"btn":93.12051455,"btt":1413869.58372996,"busd":1.10907628,"bwp":14.7823369,"byn":3.63103621,"byr":36310.3620551,"bzd":2.23427517,"cad":1.50511573,"cake":0.69238181,"cdf":3135.35156853,"celo":2.72943603,"cfx":8.70114942,"chf":0.93463164,"chz":21.95510581,"clp":1046.76964048,"cnh":7.86554289,"cny":7.85816718,"comp":0.026868419,"cop":4628.27853811,"crc":580.77620392,"cro":14.562696,"crv":4.25717867,"cspr":99.32610332,"cuc":1.108713,"cup":26.51525378,"cve":110.27000001,"cvx":0.52802737,"cyp":0.585274,"czk":25.04342026,"dai":1.10915021,"dash":0.047049753,"dcr":0.099895889,"dem":1.95583,"dfi":54.90757154,"djf":198.09911843,"dkk":7.46421522,"doge":11.56087726,"dop":66.31112579,"dot":0.26967552,"dydx":1.27415976,"dzd":147.30046343,"eek":15.64664,"egld":0.045323268,"egp":53.71292521,"enj":8.31461433,"eos":2.39495631,"ern":16.63069494,"esp":166.38600001,"etb":122.98964355,"etc":0.06275404,"eth":0.00048680993,"eur":1,"fei":1.1122571,"fil":0.3283682,"fim":5.94573,"fjd":2.46012144,"fkp":0.84430755,"flow":2.14168316,"flr":76.51502607,"frax":1.11232892,"frf":6.55957,"ftm":2.85542835,"ftt":0.88523104,"fxs":0.63379694,"gala":60.367114,"gbp":0.84430755,"gel":2.9863185,"ggp":0.84430755,"ghc":173211.68869814,"ghs":17.32116887,"gip":0.84430755,"gmd":77.60913286,"gmx":0.049021128,"gnf":9567.56028612,"gno":0.0077537794,"grd":340.75000002,"grt":8.3539066,"gt":0.15250464,"gtq":8.5738218,"gusd":1.10779808,"gyd":231.70368136,"hbar":22.92925243,"hkd":8.64311655,"hnl":27.47606418,"hnt":0.13861976,"hot":747.95676281,"hrk":7.5345,"ht":3.93329637,"htg":148.14500948,"huf":393.66192421,"icp":0.15565585,"idr":17056.6562305,"iep":0.787564,"ils":4.13074224,"imp":0.84430755,"imx":0.93922831,"inj":0.068890817,"inr":93.12051455,"iqd":1452.87844845,"irr":46568.86252908,"isk":153.07557917,"itl":1936.27000009,"jep":0.84430755,"jmd":174.60448186,"jod":0.78607751,"jpy":157.79956532,"kas":7.47161025,"kava":3.94118423,"kcs":0.14240359,"kda":2.29390068,"kes":142.34124043,"kgs":93.35363096,"khr":4508.72278507,"klay":8.80897878,"kmf":491.96775002,"knc":2.71916281,"kpw":997.84169624,"krw":1482.80751734,"ksm":0.062503351,"kwd":0.3397102,"kyd":0.90914917,"kzt":531.24309414,"lak":24591.33283599,"lbp":100309.90063184,"ldo":1.20924731,"leo":0.20297907,"link":0.11030558,"lkr":331.27811458,"lrc":9.46135763,"lrd":216.42100759,"lsl":19.79462126,"ltc":0.01787578,"ltl":3.4528,"luf":40.3399,"luna":3.42073209,"lunc":14758.9226416,"lvl":0.7028,"lyd":5.27680904,"mad":10.78930395,"mana":4.35509447,"matic":2.99807566,"mbx":3.01462758,"mdl":19.25834428,"mga":5037.60559405,"mgf":25188.02797024,"mina":2.76223212,"mkd":61.38944298,"mkr":0.00071517163,"mmk":2323.90026362,"mnt":3755.10080541,"mop":8.90241005,"mro":441.38244287,"mru":44.13824429,"mtl":0.4293,"mur":50.93351675,"mvr":17.14070195,"mwk":1921.71554437,"mxn":22.15095684,"mxv":2.66168158,"myr":4.80156768,"mzm":70588.24927748,"mzn":70.58824928,"nad":19.79462126,"near":0.30196295,"neo":0.12172266,"nexo":1.19391105,"nft":2450710.78902993,"ngn":1789.41488349,"nio":40.60583601,"nlg":2.20371,"nok":11.88204672,"npr":149.06266366,"nzd":1.79608608,"okb":0.031068667,"omr":0.4269685,"one":103.71962713,"op":0.77960358,"ordi":0.038712373,"pab":1.108713,"paxg":0.00044471837,"pen":4.21225845,"pepe":163706.6439438,"pgk":4.32920549,"php":62.28910075,"pkr":308.82253141,"pln":4.28277014,"pte":200.48200001,"pyg":8594.34539409,"qar":4.0357153,"qnt":0.018241245,"qtum":0.52573178,"rol":49718.4182033,"ron":4.97184182,"rpl":0.12313022,"rsd":116.67032956,"rub":100.13709585,"rune":0.31488658,"rvn":69.51765832,"rwf":1478.00963697,"sand":4.61703678,"sar":4.15767373,"sbd":9.12529461,"scr":16.30523309,"sdd":66407.75599417,"sdg":664.07755994,"sek":11.42004055,"sgd":1.44430507,"shib":86020.24084289,"shp":0.84430755,"sit":239.64000001,"skk":30.126,"sle":25.03473164,"sll":25034.73164482,"snx":0.87246728,"sol":0.0086754832,"sos":633.15217716,"spl":0.1847855,"srd":31.98637107,"srg":31986.37106839,"std":24503.98232642,"stn":24.50398233,"stx":0.79230901,"sui":1.24488285,"svc":9.70123871,"syp":14415.46750307,"szl":19.79462126,"thb":37.35705101,"theta":0.98890773,"tjs":11.82858956,"tmm":19402.47722259,"tmt":3.88049544,"tnd":3.36382052,"ton":0.23607138,"top":2.56887385,"trl":37660136.11839834,"trx":7.30381992,"try":37.66013612,"ttd":7.52123417,"ttt":531.18220804,"tusd":1.11105964,"tvd":1.66227405,"twd":35.55395502,"twt":1.38070881,"tzs":3012.84557233,"uah":45.66759749,"ugx":4122.07389342,"uni":0.17146946,"usd":1.108713,"usdc":1.10910921,"usdd":1.11073425,"usdp":1.10763815,"usdt":1.1092054,"uyu":44.7652144,"uzs":14089.04920278,"val":1936.27000009,"veb":4063311170.562254,"ved":40.63310262,"vef":4063310.2616386,"ves":40.63310262,"vet":54.66166643,"vnd":27279.95020283,"vuv":130.1303211,"waves":1.15871268,"wemix":1.34496809,"woo":8.09162358,"wst":2.97401297,"xaf":655.95700003,"xag":0.039694639,"xau":0.0004439329,"xaut":0.00044412767,"xbt":0.000020443781,"xcd":2.99352515,"xch":0.086479493,"xdc":42.17162181,"xdr":0.82174975,"xec":37697.95855652,"xem":70.1664657,"xlm":12.43087957,"xmr":0.006586958,"xof":655.95700003,"xpd":0.0011549093,"xpf":119.33174225,"xpt":0.0012356235,"xrp":2.10261362,"xtz":1.82335464,"yer":277.36511674,"zar":19.79462126,"zec":0.040262665,"zil":87.00250176,"zmk":29269.38619739,"zmw":29.2693862,"zwd":401.24323319,"zwg":15.6218975,"zwl":39034.81333573}}""";

const missingData =
    """{"date":"2024-09-08","usd":{"1000sats":3324.81413663,"1inch":4.41963061,"aave":0.008740758,"ada":3.36382628,"aed":4.07174848,"afn":77.88217445,"agix":2.3744766,"akt":0.48717834,"algo":9.13513745,"all":99.47451566,"amd":428.21601039,"amp":308.64917532,"ang":1.98182515,"aoa":1020.36765074,"ape":1.51028953,"apt":0.19004581,"ar":0.056114646,"arb":2.21929311,"ars":1059.93332826,"atom":0.30195945,"ats":13.7603,"aud":1.66227405,"avax":0.050650683,"awg":1.98459626,"axs":0.25987574,"azm":9424.05917757,"azn":1.88481184,"bake":4.7594085,"bam":1.95583,"bat":7.10758274,"bbd":2.21742599,"bch":0.003671689,"bdt":133.05100668,"bef":40.3399,"bgn":1.95583,"bhd":0.41687609,"bif":3194.41774245,"bmd":1.108713,"bnb":0.0022464158,"bnd":1.44430507,"bob":7.6779598,"brl":6.19863046,"bsd":1.108713,"bsv":0.025037012,"bsw":14.87693162,"btc":0.000020443781,"btcb":4.61249967,"btg":0.054115387,"btn":93.12051455,"btt":1413869.58372996,"busd":1.10907628,"bwp":14.7823369,"byn":3.63103621,"byr":36310.3620551,"bzd":2.23427517,"cad":1.50511573,"cake":0.69238181,"cdf":3135.35156853,"celo":2.72943603,"cfx":8.70114942,"chf":0.93463164,"chz":21.95510581,"clp":1046.76964048,"cnh":7.86554289,"cny":7.85816718,"comp":0.026868419,"cop":4628.27853811,"crc":580.77620392,"cro":14.562696,"crv":4.25717867,"cspr":99.32610332,"cuc":1.108713,"cup":26.51525378,"cve":110.27000001,"cvx":0.52802737,"cyp":0.585274,"czk":25.04342026,"dai":1.10915021,"dash":0.047049753,"dcr":0.099895889,"dem":1.95583,"dfi":54.90757154,"djf":198.09911843,"dkk":7.46421522,"doge":11.56087726,"dop":66.31112579,"dot":0.26967552,"dydx":1.27415976,"dzd":147.30046343,"eek":15.64664,"egld":0.045323268,"egp":53.71292521,"enj":8.31461433,"eos":2.39495631,"ern":16.63069494,"esp":166.38600001,"etb":122.98964355,"etc":0.06275404,"eth":0.00048680993,"eur":1,"fei":1.1122571,"fil":0.3283682,"fim":5.94573,"fjd":2.46012144,"fkp":0.84430755,"flow":2.14168316,"flr":76.51502607,"frax":1.11232892,"frf":6.55957,"ftm":2.85542835,"ftt":0.88523104,"fxs":0.63379694,"gala":60.367114,"gbp":0.84430755,"gel":2.9863185,"ggp":0.84430755,"ghc":173211.68869814,"ghs":17.32116887,"gip":0.84430755,"gmd":77.60913286,"gmx":0.049021128,"gnf":9567.56028612,"gno":0.0077537794,"grd":340.75000002,"grt":8.3539066,"gt":0.15250464,"gtq":8.5738218,"gusd":1.10779808,"gyd":231.70368136,"hbar":22.92925243,"hkd":8.64311655,"hnl":27.47606418,"hnt":0.13861976,"hot":747.95676281,"hrk":7.5345,"ht":3.93329637,"htg":148.14500948,"huf":393.66192421,"icp":0.15565585,"idr":17056.6562305,"iep":0.787564,"ils":4.13074224,"imp":0.84430755,"imx":0.93922831,"inj":0.068890817,"inr":93.12051455,"iqd":1452.87844845,"irr":46568.86252908,"isk":153.07557917,"itl":1936.27000009,"jep":0.84430755,"jmd":174.60448186,"jod":0.78607751,"jpy":157.79956532,"kas":7.47161025,"kava":3.94118423,"kcs":0.14240359,"kda":2.29390068,"kes":142.34124043,"kgs":93.35363096,"khr":4508.72278507,"klay":8.80897878,"kmf":491.96775002,"knc":2.71916281,"kpw":997.84169624,"krw":1482.80751734,"ksm":0.062503351,"kwd":0.3397102,"kyd":0.90914917,"kzt":531.24309414,"lak":24591.33283599,"lbp":100309.90063184,"ldo":1.20924731,"leo":0.20297907,"link":0.11030558,"lkr":331.27811458,"lrc":9.46135763,"lrd":216.42100759,"lsl":19.79462126,"ltc":0.01787578,"ltl":3.4528,"luf":40.3399,"luna":3.42073209,"lunc":14758.9226416,"lvl":0.7028,"lyd":5.27680904,"mad":10.78930395,"mana":4.35509447,"matic":2.99807566,"mbx":3.01462758,"mdl":19.25834428,"mga":5037.60559405,"mgf":25188.02797024,"mina":2.76223212,"mkd":61.38944298,"mkr":0.00071517163,"mmk":2323.90026362,"mnt":3755.10080541,"mop":8.90241005,"mro":441.38244287,"mru":44.13824429,"mtl":0.4293,"mur":50.93351675,"mvr":17.14070195,"mwk":1921.71554437,"mxn":22.15095684,"mxv":2.66168158,"myr":4.80156768,"mzm":70588.24927748,"mzn":70.58824928,"nad":19.79462126,"near":0.30196295,"neo":0.12172266,"nexo":1.19391105,"nft":2450710.78902993,"ngn":1789.41488349,"nio":40.60583601,"nlg":2.20371,"nok":11.88204672,"npr":149.06266366,"nzd":1.79608608,"okb":0.031068667,"omr":0.4269685,"one":103.71962713,"op":0.77960358,"ordi":0.038712373,"pab":1.108713,"paxg":0.00044471837,"pen":4.21225845,"pepe":163706.6439438,"pgk":4.32920549,"php":62.28910075,"pkr":308.82253141,"pln":4.28277014,"pte":200.48200001,"pyg":8594.34539409,"qar":4.0357153,"qnt":0.018241245,"qtum":0.52573178,"rol":49718.4182033,"ron":4.97184182,"rpl":0.12313022,"rsd":116.67032956,"rub":100.13709585,"rune":0.31488658,"rvn":69.51765832,"rwf":1478.00963697,"sand":4.61703678,"sar":4.15767373,"sbd":9.12529461,"scr":16.30523309,"sdd":66407.75599417,"sdg":664.07755994,"sek":11.42004055,"sgd":1.44430507,"shib":86020.24084289,"shp":0.84430755,"sit":239.64000001,"skk":30.126,"sle":25.03473164,"sll":25034.73164482,"snx":0.87246728,"sol":0.0086754832,"sos":633.15217716,"spl":0.1847855,"srd":31.98637107,"srg":31986.37106839,"std":24503.98232642,"stn":24.50398233,"stx":0.79230901,"sui":1.24488285,"svc":9.70123871,"syp":14415.46750307,"szl":19.79462126,"thb":37.35705101,"theta":0.98890773,"tjs":11.82858956,"tmm":19402.47722259,"tmt":3.88049544,"tnd":3.36382052,"ton":0.23607138,"top":2.56887385,"trl":37660136.11839834,"trx":7.30381992,"try":37.66013612,"ttd":7.52123417,"ttt":531.18220804,"tusd":1.11105964,"tvd":1.66227405,"twd":35.55395502,"twt":1.38070881,"tzs":3012.84557233,"uah":45.66759749,"ugx":4122.07389342,"uni":0.17146946,"usd":1.108713,"usdc":1.10910921,"usdd":1.11073425,"usdp":1.10763815,"usdt":1.1092054,"uyu":44.7652144,"uzs":14089.04920278,"val":1936.27000009,"veb":4063311170.562254,"ved":40.63310262,"vef":4063310.2616386,"ves":40.63310262,"vet":54.66166643,"vnd":27279.95020283,"vuv":130.1303211,"waves":1.15871268,"wemix":1.34496809,"woo":8.09162358,"wst":2.97401297,"xaf":655.95700003,"xag":0.039694639,"xau":0.0004439329,"xaut":0.00044412767,"xbt":0.000020443781,"xcd":2.99352515,"xch":0.086479493,"xdc":42.17162181,"xdr":0.82174975,"xec":37697.95855652,"xem":70.1664657,"xlm":12.43087957,"xmr":0.006586958,"xof":655.95700003,"xpd":0.0011549093,"xpf":119.33174225,"xpt":0.0012356235,"xrp":2.10261362,"xtz":1.82335464,"yer":277.36511674,"zar":19.79462126,"zec":0.040262665,"zil":87.00250176,"zmk":29269.38619739,"zmw":29.2693862,"zwd":401.24323319,"zwg":15.6218975,"zwl":39034.81333573}}""";

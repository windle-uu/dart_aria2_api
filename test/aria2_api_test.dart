import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'package:aria2_api/aria2_api.dart';

const downloadLink = ''; // replace it before test
const host = '127.0.0.1';
const port = 6800;
const path = 'jsonrpc';
const secret = 'myaria2rpcpass';

final errorLink = Uri.https(
  'example.org',
  Uri.parse(downloadLink).pathSegments.last,
).toString();
final tmpDir = Directory(p.join(Directory.current.path, 'test', 'tmp'))
  ..createSync();
final option = Aria2InputFileOption(dir: tmpDir.path);

void main() {
  group('test method in http client', () {
    late Aria2HttpClient client;

    setUp(() {
      client = Aria2HttpClient(
        host: host,
        port: port,
        path: path,
        secret: secret,
        func: Aria2HttpFunction.post,
      );
    });

    tearDown(() async {
      await client.purgeDownloadResult();
      await client.disconnect();
      await Future.delayed(const Duration(milliseconds: 100));
      await tmpDir.list().forEach((e) async => await e.delete(recursive: true));
    });

    test('aria2.addUri', () async {
      final response = await client.addUri([downloadLink], option);
      final gid = response.getOrNull()?.result.getOrNull()?.value;
      expect(gid, isNotNull);

      await client.forceRemove(gid!);
    });

    test('aria2.addTorrent', () {
      // TODO: implement
    }, skip: true);

    test('aria2.addMetalink', () async {
      // TODO: implement
    }, skip: true);

    test('aria2.remove', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.remove(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.forceRemove', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.forceRemove(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.pause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.pause(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.pauseAll', () async {
      final response = await client.pauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.forcePause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.forcePause(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.forcePauseAll', () async {
      final response = await client.forcePauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.unpause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fPause = await client.forcePause(addGid!);
      expect(
        fPause.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.unpause(addGid);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.unpauseAll', () async {
      final response = await client.unpauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.tellStatus', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.tellStatus(
        addGid!,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getUris', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getUris(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getFiles', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getFiles(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getPeers', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getPeers(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getServers', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getServers(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.tellActive', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.tellActive(
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid!);
    });

    test('aria2.tellWaiting', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fPause = await client.forcePause(addGid!);
      expect(
        fPause.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.tellWaiting(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.tellStopped', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fRemove = await client.forceRemove(addGid!);
      expect(
        fRemove.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.tellStopped(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.changePosition', () async {
      final globalOption = await client.getGlobalOption();
      final globalOptionResponse = globalOption.getOrNull()?.result.getOrNull();
      expect(globalOptionResponse, isNotNull);
      final concurrent = globalOptionResponse!.maxConcurrentDownloads;

      await client.changeGlobalOption(
        Aria2OptionObject.global(maxConcurrentDownloads: 1),
      );

      final addList = await client.batchCall([
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
      ]);

      final waiting = await client.tellWaiting(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true),
      );
      final waitingList = waiting.getOrNull()?.result.getOrNull();
      expect(waitingList, allOf(isNotNull, isNotEmpty));
      final waitingGid = waitingList!.first.gid;

      final response = await client.changePosition(
        waitingGid!,
        0,
        Aria2PositionSymbol.posSet,
      );
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(0)),
      );

      await client.changeGlobalOption(
        Aria2OptionObject.global(maxConcurrentDownloads: concurrent),
      );
      for (final i in addList.getOrThrow().responses) {
        final gid = i.result.castOrNull<Aria2StringResult>()?.value;
        if (gid != null) await client.forceRemove(gid);
      }
    });

    test('aria2.changeUri', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      await Future.delayed(const Duration(seconds: 2));
      final response = await client.changeUri(
        addGid!,
        1,
        [downloadLink, downloadLink],
        [errorLink],
      );
      expect(
        response.getOrNull()?.result.getOrNull(),
        allOf(isNotNull, hasLength(2)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.getOption', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getOption(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.changeOption', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.changeOption(
        addGid!,
        Aria2OptionObject(timeout: 30),
      );
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getGlobalOption', () async {
      final response = await client.getGlobalOption();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.changeGlobalOption', () async {
      final response = await client.changeGlobalOption(
        Aria2OptionObject(timeout: 60),
      );
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.getGlobalStat', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getGlobalStat();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid!);
    });

    test('aria2.purgeDownloadResult', () async {
      final response = await client.purgeDownloadResult();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.removeDownloadResult', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fRemove = await client.forceRemove(addGid!);
      expect(
        fRemove.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.removeDownloadResult(addGid);
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.getVersion', () async {
      final response = await client.getVersion();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.getSessionInfo', () async {
      final response = await client.getSessionInfo();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.saveSession', () async {
      final response = await client.saveSession();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('system.multicall', () async {
      final methods = [
        // error
        Aria2Method(Aria2MethodName.addTorrent, Aria2ParameterBuilder.empty()),
        // string
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        // object list
        Aria2Method(
          Aria2MethodName.tellStopped,
          Aria2ParameterBuilder.normal([
            0,
            20,
            Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
          ]),
        ),
        // object
        Aria2Method(Aria2MethodName.getVersion, Aria2ParameterBuilder.empty()),
      ];

      final multi = await client.multicall(methods);
      final result = multi.getOrNull()?.responses;
      expect(result, allOf(isNotNull, hasLength(methods.length)));
      final responses = result!;

      expect(responses[0].exceptionOrNull(), isNotNull);

      final addResponse = responses[1].castOrNull<Aria2StringResult>();
      expect(addResponse, isNotNull);
      final addGid = addResponse!.value;
      await client.forceRemove(addGid);

      expect(
        responses[2].castListOrNull<Aria2DownloadingStatusObject>(),
        isNotNull,
      );

      expect(
        responses[3].castOrNull<Aria2VersionObject>(),
        isA<Aria2VersionObject>(),
      );
    });

    test('batch call', () async {
      final methods = [
        // error
        Aria2Method(Aria2MethodName.addTorrent, Aria2ParameterBuilder.empty()),
        // string
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        // object list
        Aria2Method(
          Aria2MethodName.tellStopped,
          Aria2ParameterBuilder.normal([
            0,
            20,
            Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
          ]),
        ),
        // object
        Aria2Method(Aria2MethodName.getVersion, Aria2ParameterBuilder.empty()),
      ];

      final batch = await client.batchCall(methods);
      final result = batch.getOrThrow();

      // error
      expect(result.responses[0].result.exceptionOrNull(), isNotNull);
      // string
      final addGid = result.responses[1].result
          .castOrNull<Aria2StringResult>()
          ?.value;
      expect(addGid, isNotNull);
      await client.forceRemove(addGid!);
      // object list
      expect(
        result.responses[2].result
            .castListOrNull<Aria2DownloadingStatusObject>(),
        isNotNull,
      );
      // object
      expect(
        result.responses[3].result.castOrNull<Aria2VersionObject>(),
        isNotNull,
      );
    });

    test('system.listMethods', () async {
      final response = await client.listMethods();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('system.listNotifications', () async {
      final response = await client.listNotifications();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });
  });

  group('test method in websocket client', () {
    late Aria2WebSocketClient client;

    setUp(() {
      client = Aria2WebSocketClient(
        host: host,
        port: port,
        path: path,
        secret: secret,
      );
    });

    tearDown(() async {
      await client.purgeDownloadResult();
      await client.disconnect();
      await Future.delayed(const Duration(milliseconds: 100));
      await tmpDir.list().forEach((e) async => await e.delete(recursive: true));
    });

    test('aria2.addUri', () async {
      final response = await client.addUri([downloadLink], option);
      final gid = response.getOrNull()?.result.getOrNull()?.value;
      expect(gid, isNotNull);

      await client.forceRemove(gid!);
    });

    test('aria2.addTorrent', () {
      // TODO: implement
    }, skip: true);

    test('aria2.addMetalink', () async {
      // TODO: implement
    }, skip: true);

    test('aria2.remove', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.remove(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.forceRemove', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.forceRemove(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.pause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.pause(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.pauseAll', () async {
      final response = await client.pauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.forcePause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.forcePause(addGid!);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.forcePauseAll', () async {
      final response = await client.forcePauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.unpause', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fPause = await client.forcePause(addGid!);
      expect(
        fPause.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.unpause(addGid);
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
    });

    test('aria2.unpauseAll', () async {
      final response = await client.unpauseAll();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.tellStatus', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.tellStatus(
        addGid!,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getUris', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getUris(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getFiles', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getFiles(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getPeers', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getPeers(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getServers', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getServers(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.tellActive', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.tellActive(
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid!);
    });

    test('aria2.tellWaiting', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fPause = await client.forcePause(addGid!);
      expect(
        fPause.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.tellWaiting(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.tellStopped', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fRemove = await client.forceRemove(addGid!);
      expect(
        fRemove.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.tellStopped(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
      );
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.changePosition', () async {
      final globalOption = await client.getGlobalOption();
      final globalOptionResponse = globalOption.getOrNull()?.result.getOrNull();
      expect(globalOptionResponse, isNotNull);
      final concurrent = globalOptionResponse!.maxConcurrentDownloads;

      await client.changeGlobalOption(
        Aria2OptionObject.global(maxConcurrentDownloads: 1),
      );

      final addList = await client.batchCall([
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
      ]);

      final waiting = await client.tellWaiting(
        0,
        10,
        Aria2DownloadingStatusObject.buildKeys(gid: true),
      );
      final waitingList = waiting.getOrNull()?.result.getOrNull();
      expect(waitingList, allOf(isNotNull, isNotEmpty));
      final waitingGid = waitingList!.first.gid;

      final response = await client.changePosition(
        waitingGid!,
        0,
        Aria2PositionSymbol.posSet,
      );
      expect(
        response.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(0)),
      );

      await client.changeGlobalOption(
        Aria2OptionObject.global(maxConcurrentDownloads: concurrent),
      );
      for (final i in addList.getOrThrow().responses) {
        final gid = i.result.castOrNull<Aria2StringResult>()?.value;
        if (gid != null) await client.forceRemove(gid);
      }
    });

    test('aria2.changeUri', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      await Future.delayed(const Duration(seconds: 2));
      final response = await client.changeUri(
        addGid!,
        1,
        [downloadLink, downloadLink],
        [errorLink],
      );
      expect(
        response.getOrNull()?.result.getOrNull(),
        allOf(isNotNull, hasLength(2)),
      );
      await client.forceRemove(addGid);
    });

    test('aria2.getOption', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getOption(addGid!);
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.changeOption', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.changeOption(
        addGid!,
        Aria2OptionObject(timeout: 30),
      );
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
      await client.forceRemove(addGid);
    });

    test('aria2.getGlobalOption', () async {
      final response = await client.getGlobalOption();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.changeGlobalOption', () async {
      final response = await client.changeGlobalOption(
        Aria2OptionObject(timeout: 60),
      );
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.getGlobalStat', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final response = await client.getGlobalStat();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
      await client.forceRemove(addGid!);
    });

    test('aria2.purgeDownloadResult', () async {
      final response = await client.purgeDownloadResult();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.removeDownloadResult', () async {
      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      final fRemove = await client.forceRemove(addGid!);
      expect(
        fRemove.getOrNull()?.result.getOrNull()?.value,
        allOf(isNotNull, equals(addGid)),
      );
      final response = await client.removeDownloadResult(addGid);
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('aria2.getVersion', () async {
      final response = await client.getVersion();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.getSessionInfo', () async {
      final response = await client.getSessionInfo();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('aria2.saveSession', () async {
      final response = await client.saveSession();
      expect(response.getOrNull()?.result.getOrNull()?.value, isNotNull);
    });

    test('system.multicall', () async {
      final methods = [
        // error
        Aria2Method(Aria2MethodName.addTorrent, Aria2ParameterBuilder.empty()),
        // string
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        // object list
        Aria2Method(
          Aria2MethodName.tellStopped,
          Aria2ParameterBuilder.normal([
            0,
            20,
            Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
          ]),
        ),
        // object
        Aria2Method(Aria2MethodName.getVersion, Aria2ParameterBuilder.empty()),
      ];

      final multi = await client.multicall(methods);
      final result = multi.getOrNull()?.responses;
      expect(result, allOf(isNotNull, hasLength(methods.length)));
      final responses = result!;

      expect(responses[0].exceptionOrNull(), isNotNull);

      final addResponse = responses[1].castOrNull<Aria2StringResult>();
      expect(addResponse, isNotNull);
      final addGid = addResponse!.value;
      await client.forceRemove(addGid);

      expect(
        responses[2].castListOrNull<Aria2DownloadingStatusObject>(),
        isNotNull,
      );

      expect(
        responses[3].castOrNull<Aria2VersionObject>(),
        isA<Aria2VersionObject>(),
      );
    });

    test('batch call', () async {
      final methods = [
        // error
        Aria2Method(Aria2MethodName.addTorrent, Aria2ParameterBuilder.empty()),
        // string
        Aria2Method(
          Aria2MethodName.addUri,
          Aria2ParameterBuilder.normal([
            [downloadLink],
            option.parametrized,
          ]),
        ),
        // object list
        Aria2Method(
          Aria2MethodName.tellStopped,
          Aria2ParameterBuilder.normal([
            0,
            20,
            Aria2DownloadingStatusObject.buildKeys(gid: true, status: true),
          ]),
        ),
        // object
        Aria2Method(Aria2MethodName.getVersion, Aria2ParameterBuilder.empty()),
      ];

      final batch = await client.batchCall(methods);
      final result = batch.getOrThrow();

      // error
      expect(result.responses[0].result.exceptionOrNull(), isNotNull);
      // string
      final addGid = result.responses[1].result
          .castOrNull<Aria2StringResult>()
          ?.value;
      expect(addGid, isNotNull);
      await client.forceRemove(addGid!);
      // object list
      expect(
        result.responses[2].result
            .castListOrNull<Aria2DownloadingStatusObject>(),
        isNotNull,
      );
      // object
      expect(
        result.responses[3].result.castOrNull<Aria2VersionObject>(),
        isNotNull,
      );
    });

    test('system.listMethods', () async {
      final response = await client.listMethods();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });

    test('system.listNotifications', () async {
      final response = await client.listNotifications();
      expect(response.getOrNull()?.result.getOrNull(), isNotNull);
    });
  });

  group('test error', () {
    test('http client error', () async {
      final client = Aria2HttpClient(
        host: '127.0.0.1',
        port: 10020,
        func: Aria2HttpFunction.post,
      );
      final response = await client.addUri([downloadLink]);
      expect(response.exceptionOrNull(), isNotNull);
      await client.disconnect();
    });

    test('websocket client error', () async {
      final client = Aria2WebSocketClient(host: '127.0.0.1', port: 10020);
      final response = await client.addUri([downloadLink]);
      expect(response.exceptionOrNull(), isNotNull);
      await client.disconnect();
    });

    test('aria2 error', () async {
      final client = Aria2HttpClient(
        host: host,
        port: port,
        path: path,
        secret: secret,
        func: Aria2HttpFunction.post,
      );
      final response = await client.addUri([]);
      expect(response.getOrNull()?.result.exceptionOrNull(), isNotNull);
      await client.disconnect();
    });
  });

  group('test notification', () {
    late Aria2WebSocketClient client;

    setUp(() {
      client = Aria2WebSocketClient(
        host: host,
        port: port,
        path: path,
        secret: secret,
      );
    });

    tearDown(() async {
      await client.purgeDownloadResult();
      await client.disconnect();
      await tmpDir.list().forEach((e) async => await e.delete(recursive: true));
    });

    test('aria2.onDownloadStart', () async {
      final storage = <String>[];
      final subscription = client.notification.listen((e) {
        if (e.method == Aria2NotificationName.onDownloadStart) {
          final list = e.data.value.map((f) => f.gid).toList();
          storage.addAll(list);
        }
      });

      final response = await client.addUri([downloadLink], option);
      final gid = response.getOrNull()?.result.getOrNull()?.value;
      expect(gid, isNotNull);
      await Future.delayed(const Duration(milliseconds: 200));
      expect(storage, contains(gid));

      await subscription.cancel();
      await client.forceRemove(gid!);
    });

    test('aria2.onDownloadPause', () async {
      final storage = <String>[];
      final subscription = client.notification.listen((e) {
        if (e.method == Aria2NotificationName.onDownloadPause) {
          final list = e.data.value.map((f) => f.gid).toList();
          storage.addAll(list);
        }
      });

      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      await Future.delayed(const Duration(milliseconds: 200));
      final pause = await client.pause(addGid!);
      final pauseGid = pause.getOrNull()?.result.getOrNull()?.value;
      expect(pauseGid, isNotNull);
      await Future.delayed(const Duration(milliseconds: 200));
      expect(storage, contains(pauseGid));

      await subscription.cancel();
      await client.forceRemove(addGid);
    });

    test('aria2.onDownloadStop', () async {
      final storage = <String>[];
      final subscription = client.notification.listen((e) {
        if (e.method == Aria2NotificationName.onDownloadStop) {
          final list = e.data.value.map((f) => f.gid).toList();
          storage.addAll(list);
        }
      });

      final add = await client.addUri([downloadLink], option);
      final addGid = add.getOrNull()?.result.getOrNull()?.value;
      expect(addGid, isNotNull);
      await Future.delayed(const Duration(milliseconds: 200));
      final remove = await client.remove(addGid!);
      final removeGid = remove.getOrNull()?.result.getOrNull()?.value;
      expect(removeGid, isNotNull);
      await Future.delayed(const Duration(milliseconds: 200));
      expect(storage, contains(removeGid));

      await subscription.cancel();
      await client.forceRemove(addGid);
    });

    test('aria2.onDownloadComplete', () async {
      final completer = Completer<void>();
      String? addGid;
      final subscription = client.notification.listen((e) {
        final list = e.data.value.map((f) => f.gid).toList();
        if (addGid == null || !list.contains(addGid)) return;
        if (e.method == Aria2NotificationName.onDownloadComplete) {
          if (!completer.isCompleted) completer.complete();
        } else if (e.method == Aria2NotificationName.onDownloadError) {
          if (!completer.isCompleted) completer.completeError('Error');
        }
      });

      try {
        final add = await client.addUri([downloadLink], option);
        addGid = add.getOrNull()?.result.getOrNull()?.value;
        expect(addGid, isNotNull);

        await completer.future.timeout(const Duration(seconds: 30));
      } finally {
        await subscription.cancel();
      }
    });

    test('aria2.onDownloadError', () async {
      final completer = Completer<void>();
      String? addGid;
      final subscription = client.notification.listen((e) {
        final list = e.data.value.map((f) => f.gid).toList();
        if (addGid == null || !list.contains(addGid)) return;
        if (e.method == Aria2NotificationName.onDownloadError) {
          if (!completer.isCompleted) completer.complete();
        } else if (e.method == Aria2NotificationName.onDownloadComplete) {
          if (!completer.isCompleted) completer.completeError('Not a error');
        }
      });

      try {
        final add = await client.addUri([downloadLink], option);
        addGid = add.getOrNull()?.result.getOrNull()?.value;
        expect(addGid, isNotNull);
        await Future.delayed(const Duration(seconds: 2));
        final changeUri = await client.changeUri(
          addGid!,
          1,
          [downloadLink, downloadLink],
          [errorLink],
        );
        expect(
          changeUri.getOrNull()?.result.getOrNull(),
          allOf(isNotNull, hasLength(2)),
        );

        await completer.future.timeout(const Duration(seconds: 30));
        await client.forceRemove(addGid);
      } finally {
        await subscription.cancel();
      }
    });

    test('aria2.onBtDownloadComplete', () {
      // TODO: implement
    }, skip: true);
  });
}

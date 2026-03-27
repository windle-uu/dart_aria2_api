import 'package:aria2_api/src/enum.dart';
import 'package:aria2_api/src/helper.dart';
import 'package:aria2_api/src/struct.dart';
import 'package:collection/collection.dart';

const _keyMatcher = SetEquality<String>();

T? _buildConversion<T>(dynamic value, T Function(dynamic) converter) {
  return value != null ? converter(value) : null;
}

class Aria2DownloadingFileObject extends Aria2ObjectResult {
  final int index;
  final String path;
  final int length;
  final int completedLength;
  final bool selected;
  final List<Aria2DownloadingUriObject> uris;

  const Aria2DownloadingFileObject({
    required this.index,
    required this.path,
    required this.length,
    required this.completedLength,
    required this.selected,
    required this.uris,
  });

  Aria2DownloadingFileObject.fromJson(Map<String, dynamic> json)
    : this(
        index: int.parse(json['index']),
        path: json['path'],
        length: int.parse(json['length']),
        completedLength: int.parse(json['completedLength']),
        selected: bool.parse(json['selected']),
        uris: (json['uris'] as List)
            .map((e) => Aria2DownloadingUriObject.fromJson(e))
            .toList(),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll([
            'index: $index',
            'path: $path',
            'length: $length',
            'completedLength: $completedLength',
            'selected: $selected',
            'uris: $uris',
          ], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {
      'index',
      'path',
      'length',
      'completedLength',
      'selected',
      'uris',
    });
  }
}

class Aria2DownloadingPeerObject extends Aria2ObjectResult {
  final String peerId;
  final String ip;
  final int port;
  final String bitfield;
  final bool amChoking;
  final bool peerChoking;
  final int downloadSpeed;
  final int uploadSpeed;
  final bool seeder;

  const Aria2DownloadingPeerObject({
    required this.peerId,
    required this.ip,
    required this.port,
    required this.bitfield,
    required this.amChoking,
    required this.peerChoking,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.seeder,
  });

  Aria2DownloadingPeerObject.fromJson(Map<String, dynamic> json)
    : this(
        peerId: json['peerId'],
        ip: json['ip'],
        port: int.parse(json['port']),
        bitfield: json['bitfield'],
        amChoking: bool.parse(json['amChoking']),
        peerChoking: bool.parse(json['peerChoking']),
        downloadSpeed: int.parse(json['downloadSpeed']),
        uploadSpeed: int.parse(json['uploadSpeed']),
        seeder: bool.parse(json['seeder']),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll([
            'peerId: $peerId',
            'ip: $ip',
            'bitfield: $bitfield',
            'amChoking: $amChoking',
            'peerChoking: $peerChoking',
            'downloadSpeed: $downloadSpeed',
            'uploadSpeed: $uploadSpeed',
            'seeder: $seeder',
          ], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {
      'peerId',
      'ip',
      'bitfield',
      'amChoking',
      'peerChoking',
      'downloadSpeed',
      'uploadSpeed',
      'seeder',
    });
  }
}

class Aria2DownloadingStatusObject extends Aria2ObjectResult {
  final String? gid;
  final Aria2DownloadingStatus? status;
  final int? totalLength;
  final int? completedLength;
  final int? uploadLength;
  final String? bitfield;
  final int? downloadSpeed;
  final int? uploadSpeed;
  final String? infoHash;
  final int? numSeeders;
  final bool? seeder;
  final int? pieceLength;
  final int? numPieces;
  final int? connections;
  final int? errorCode;
  final String? errorMessage;
  final List<String>? followedBy;
  final String? following;
  final String? belongsTo;
  final String? dir;
  final List<Aria2DownloadingFileObject>? files;
  final Aria2BitTorrentData? bittorrent;
  final int? verifiedLength;
  final bool? verifyIntegrityPending;

  const Aria2DownloadingStatusObject({
    this.gid,
    this.status,
    this.totalLength,
    this.completedLength,
    this.uploadLength,
    this.bitfield,
    this.downloadSpeed,
    this.uploadSpeed,
    this.infoHash,
    this.numSeeders,
    this.seeder,
    this.pieceLength,
    this.numPieces,
    this.connections,
    this.errorCode,
    this.errorMessage,
    this.followedBy,
    this.following,
    this.belongsTo,
    this.dir,
    this.files,
    this.bittorrent,
    this.verifiedLength,
    this.verifyIntegrityPending,
  });

  Aria2DownloadingStatusObject.fromJson(Map<String, dynamic> json)
    : this(
        gid: json['gid_alias'],
        status: _buildConversion(
          json['status'],
          (e) => Aria2DownloadingStatus.values.byName(e),
        ),
        totalLength: _buildConversion(json['totalLength'], (e) => int.parse(e)),
        completedLength: _buildConversion(
          json['completedLength'],
          (e) => int.parse(e),
        ),
        uploadLength: _buildConversion(
          json['uploadLength'],
          (e) => int.parse(e),
        ),
        bitfield: json['bitfield'],
        downloadSpeed: _buildConversion(
          json['downloadSpeed'],
          (e) => int.parse(e),
        ),
        uploadSpeed: _buildConversion(json['uploadSpeed'], (e) => int.parse(e)),
        infoHash: json['infoHash'],
        numSeeders: _buildConversion(json['numSeeders'], (e) => int.parse(e)),
        seeder: _buildConversion(json['seeder'], (e) => bool.parse(e)),
        pieceLength: _buildConversion(json['pieceLength'], (e) => int.parse(e)),
        numPieces: _buildConversion(json['numPieces'], (e) => int.parse(e)),
        connections: _buildConversion(json['connections'], (e) => int.parse(e)),
        errorCode: _buildConversion(json['errorCode'], (e) => int.parse(e)),
        errorMessage: json['errorMessage'],
        followedBy: json['followedBy'],
        following: json['following'],
        belongsTo: json['belongsTo'],
        dir: json['dir_alias'],
        files: _buildConversion(
          json['files'],
          (e) => (e as List<dynamic>)
              .map((f) => Aria2DownloadingFileObject.fromJson(f))
              .toList(),
        ),
        bittorrent: _buildConversion(
          json['bittorrent'],
          (e) => Aria2BitTorrentData.fromMap(e),
        ),
        verifiedLength: _buildConversion(
          json['verifiedLength'],
          (e) => int.parse(e),
        ),
        verifyIntegrityPending: _buildConversion(
          json['verifyIntegrityPending'],
          (e) => bool.parse(e),
        ),
      );

  @override
  int get hashCode => Object.hashAll([
    gid,
    status,
    totalLength,
    completedLength,
    uploadLength,
    bitfield,
    downloadSpeed,
    uploadSpeed,
    infoHash,
    numSeeders,
    seeder,
    pieceLength,
    numPieces,
    connections,
    errorCode,
    errorMessage,
    followedBy,
    following,
    belongsTo,
    dir,
    files,
    bittorrent,
    verifiedLength,
    verifyIntegrityPending,
  ]);

  Map<String, dynamic> get jsonMap {
    final result = <String, dynamic>{};

    if (gid != null) result['gid'] = gid;
    if (status != null) result['status'] = status;
    if (totalLength != null) result['totalLength'] = totalLength;
    if (completedLength != null) result['completedLength'] = completedLength;
    if (uploadLength != null) result['uploadLength'] = uploadLength;
    if (bitfield != null) result['bitfield'] = bitfield;
    if (downloadSpeed != null) result['downloadSpeed'] = downloadSpeed;
    if (uploadSpeed != null) result['uploadSpeed'] = uploadSpeed;
    if (infoHash != null) result['infoHash'] = infoHash;
    if (numSeeders != null) result['numSeeders'] = numSeeders;
    if (seeder != null) result['seeder'] = seeder;
    if (pieceLength != null) result['pieceLength'] = pieceLength;
    if (numPieces != null) result['numPieces'] = numPieces;
    if (connections != null) result['connections'] = connections;
    if (errorCode != null) result['errorCode'] = errorCode;
    if (errorMessage != null) result['errorMessage'] = errorMessage;
    if (followedBy != null) result['followedBy'] = followedBy;
    if (following != null) result['following'] = following;
    if (belongsTo != null) result['belongsTo'] = belongsTo;
    if (dir != null) result['dir'] = dir;
    if (files != null) result['files'] = files;
    if (bittorrent != null) result['bittorrent'] = bittorrent;
    if (verifiedLength != null) result['verifiedLength'] = verifiedLength;
    if (verifyIntegrityPending != null) {
      result['verifyIntegrityPending'] = verifyIntegrityPending;
    }

    return result;
  }

  @override
  bool operator ==(Object other) {
    return other is Aria2DownloadingStatusObject &&
        other.gid == gid &&
        other.status == status &&
        other.totalLength == totalLength &&
        other.completedLength == completedLength &&
        other.uploadLength == uploadLength &&
        other.bitfield == bitfield &&
        other.downloadSpeed == downloadSpeed &&
        other.uploadSpeed == uploadSpeed &&
        other.infoHash == infoHash &&
        other.numSeeders == numSeeders &&
        other.seeder == seeder &&
        other.pieceLength == pieceLength &&
        other.numPieces == numPieces &&
        other.connections == connections &&
        other.errorCode == errorCode &&
        other.errorMessage == errorMessage &&
        other.followedBy == followedBy &&
        other.following == following &&
        other.belongsTo == belongsTo &&
        other.dir == dir &&
        other.files == files &&
        other.bittorrent == bittorrent &&
        other.verifiedLength == verifiedLength &&
        other.verifyIntegrityPending == verifyIntegrityPending;
  }

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll(jsonMap.entries.map((e) => '${e.key}: ${e.value}'), ', ')
          ..write(')'))
        .toString();
  }

  /// If all parameter are false, keys will be an empty list.
  /// If keys is empty or omitted, the response contains all keys.
  static List<String> buildKeys({
    bool gid = true,
    bool status = false,
    bool totalLength = false,
    bool completedLength = false,
    bool uploadLength = false,
    bool bitfield = false,
    bool downloadSpeed = false,
    bool uploadSpeed = false,
    bool infoHash = false,
    bool numSeeders = false,
    bool seeder = false,
    bool pieceLength = false,
    bool numPieces = false,
    bool connections = false,
    bool errorCode = false,
    bool errorMessage = false,
    bool followedBy = false,
    bool following = false,
    bool belongsTo = false,
    bool dir = false,
    bool files = false,
    bool bittorrent = false,
    bool verifiedLength = false,
    bool verifyIntegrityPending = false,
  }) {
    return [
      if (gid) 'gid',
      if (status) 'status',
      if (totalLength) 'totalLength',
      if (completedLength) 'completedLength',
      if (uploadLength) 'uploadLength',
      if (bitfield) 'bitfield',
      if (downloadSpeed) 'downloadSpeed',
      if (uploadSpeed) 'uploadSpeed',
      if (infoHash) 'infoHash',
      if (numSeeders) 'numSeeders',
      if (seeder) 'seeder',
      if (pieceLength) 'pieceLength',
      if (numPieces) 'numPieces',
      if (connections) 'connections',
      if (errorCode) 'errorCode',
      if (errorMessage) 'errorMessage',
      if (followedBy) 'followedBy',
      if (following) 'following',
      if (belongsTo) 'belongsTo',
      if (dir) 'dir',
      if (files) 'files',
      if (bittorrent) 'bittorrent',
      if (verifiedLength) 'verifiedLength',
      if (verifyIntegrityPending) 'verifyIntegrityPending',
    ];
  }

  static bool _anyKeyMatch(Set<String> keySet) {
    return keySet.any(
      (e) => const {
        'gid_alias',
        'status',
        'totalLength',
        'completedLength',
        'uploadLength',
        'bitfield',
        'downloadSpeed',
        'uploadSpeed',
        'infoHash',
        'numSeeders',
        'seeder',
        'pieceLength',
        'numPieces',
        'connections',
        'errorCode',
        'errorMessage',
        'followedBy',
        'following',
        'belongsTo',
        'dir_alias',
        'files',
        'bittorrent',
        'verifiedLength',
        'verifyIntegrityPending',
      }.contains(e),
    );
  }
}

class Aria2DownloadingUriObject extends Aria2ObjectResult {
  final String uri;
  final Aria2UriStatus status;

  const Aria2DownloadingUriObject({required this.uri, required this.status});

  Aria2DownloadingUriObject.fromJson(Map<String, dynamic> json)
    : this(
        uri: json['uri'],
        status: Aria2UriStatus.values.byName(json['status']),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll(['uri: $uri', 'status: $status'], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {'uri', 'status'});
  }
}

class Aria2GlobalStatObject extends Aria2ObjectResult {
  final int downloadSpeed;
  final int uploadSpeed;
  final int numActive;
  final int numWaiting;
  final int numStopped;
  final int numStoppedTotal;

  const Aria2GlobalStatObject({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.numActive,
    required this.numWaiting,
    required this.numStopped,
    required this.numStoppedTotal,
  });

  Aria2GlobalStatObject.fromJson(Map<String, dynamic> json)
    : this(
        downloadSpeed: int.parse(json['downloadSpeed']),
        uploadSpeed: int.parse(json['uploadSpeed']),
        numActive: int.parse(json['numActive']),
        numWaiting: int.parse(json['numWaiting']),
        numStopped: int.parse(json['numStopped']),
        numStoppedTotal: int.parse(json['numStoppedTotal']),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll([
            'downloadSpeed: $downloadSpeed',
            'uploadSpeed: $uploadSpeed',
            'numActive: $numActive',
            'numWaiting: $numWaiting',
            'numStopped: $numStopped',
            'numStoppedTotal: $numStoppedTotal',
          ], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {
      'downloadSpeed',
      'uploadSpeed',
      'numActive',
      'numWaiting',
      'numStopped',
      'numStoppedTotal',
    });
  }
}

class Aria2IntegerResult extends Aria2Result {
  final int value;

  const Aria2IntegerResult(this.value);

  @override
  String toString() {
    return value.toString();
  }
}

class Aria2LinkedServerObject extends Aria2ObjectResult {
  final int index;
  final List<Aria2LinkedServerInfo> servers;

  const Aria2LinkedServerObject({required this.index, required this.servers});

  Aria2LinkedServerObject.fromJson(Map<String, dynamic> json)
    : this(
        index: int.parse(json['index']),
        servers: (json['servers'] as List)
            .map((e) => Aria2LinkedServerInfo.fromMap(e))
            .toList(),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll(['index: $index', 'servers: $servers'], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {'index', 'servers'});
  }
}

sealed class Aria2ObjectResult extends Aria2Result {
  const Aria2ObjectResult();

  factory Aria2ObjectResult.build(Map<String, dynamic> json) {
    final keySet = json.keys.toSet();

    // all match
    if (Aria2DownloadingFileObject._keyMatch(keySet)) {
      return Aria2DownloadingFileObject.fromJson(json);
    }
    if (Aria2DownloadingUriObject._keyMatch(keySet)) {
      return Aria2DownloadingUriObject.fromJson(json);
    }
    if (Aria2DownloadingPeerObject._keyMatch(keySet)) {
      return Aria2DownloadingPeerObject.fromJson(json);
    }
    if (Aria2GlobalStatObject._keyMatch(keySet)) {
      return Aria2GlobalStatObject.fromJson(json);
    }
    if (Aria2LinkedServerObject._keyMatch(keySet)) {
      return Aria2LinkedServerObject.fromJson(json);
    }
    if (Aria2SessionInfoObject._keyMatch(keySet)) {
      return Aria2SessionInfoObject.fromJson(json);
    }
    if (Aria2VersionObject._keyMatch(keySet)) {
      return Aria2VersionObject.fromJson(json);
    }

    // any match
    if (Aria2DownloadingStatusObject._anyKeyMatch(keySet)) {
      return Aria2DownloadingStatusObject.fromJson(json);
    }
    if (Aria2OptionObject._anyKeyMatch(keySet)) {
      return Aria2OptionObject.fromJson(json);
    }

    throw FormatException('Wrong json data.', json);
  }
}

class Aria2OptionObject extends Aria2InputFileOption
    implements Aria2ObjectResult {
  /// Specify maximum number of files to open in multi-file BitTorrent/Metalink download globally. Default: 100
  final int? btMaxOpenFiles;

  /// This option changes the way Download Results is formatted. If OPT is default, print GID, status, average download speed and path/URI. If multiple files are involved, path/URI of first requested file is printed and remaining ones are omitted. If OPT is full, print GID, status, average download speed, percentage of progress and path/URI. The percentage of progress and path/URI are printed for each requested file in each row. If OPT is hide, Download Results is hidden. Default: default
  final Aria2DownloadResult? downloadResult;

  /// Keep unfinished download results even if doing so exceeds --max-download-result. This is useful if all unfinished downloads must be saved in session file (see --save-session option). Please keep in mind that there is no upper bound to the number of unfinished download result to keep. If that is undesirable, turn this option off. Default: true
  final bool? keepUnfinishedDownloadResult;

  /// The file name of the log file. If - is specified, log is written to stdout. If empty string is specified, or this option is omitted, no log is written to disk at all.
  final String? log;

  /// Set log level to output. LEVEL is either debug, info, notice, warn or error. Default: debug
  final Aria2LogLevel? logLevel;

  /// Set the maximum number of parallel downloads for every queue item. See also the --split option. Default: 5
  /// Note
  /// --max-concurrent-downloads limits the number of items which are downloaded concurrently. --split and --min-split-size affect the number of connections inside each item. Imagine that you have an input file (see --input-file option) like this:
  /// http://example.com/foo
  /// http://example.com/bar
  /// Here is 2 download items. aria2 can download these items concurrently if the value more than or equal 2 is given to --max-concurrent-downloads. In each download item, you can configure the number of connections using --split and/or --min-split-size, etc.
  final int? maxConcurrentDownloads;

  /// Set maximum number of download result kept in memory. The download results are completed/error/removed downloads. The download results are stored in FIFO queue and it can store at most NUM download results. When queue is full and new download result is created, oldest download result is removed from the front of the queue and new one is pushed to the back. Setting big number in this option may result high memory consumption after thousands of downloads. Specifying 0 means no download result is kept. Note that unfinished downloads are kept in memory regardless of this option value. See --keep-unfinished-download-result option. Default: 1000
  final int? maxDownloadResult;

  /// Set max overall download speed in bytes/sec. 0 means unrestricted. You can append K or M (1K = 1024, 1M = 1024K). To limit the download speed per download, use --max-download-limit option. Default: 0
  final String? maxOverallDownloadLimit;

  /// Set max overall upload speed in bytes/sec. 0 means unrestricted. You can append K or M (1K = 1024, 1M = 1024K). To limit the upload speed per torrent, use --max-upload-limit option. Default: 0
  final String? maxOverallUploadLimit;

  /// Optimizes the number of concurrent downloads according to the bandwidth available. aria2 uses the download speed observed in the previous downloads to adapt the number of downloads launched in parallel according to the rule N = A + B Log10(speed in Mbps). The coefficients A and B can be customized in the option arguments with A and B separated by a colon. The default values (A=5, B=25) lead to using typically 5 parallel downloads on 1Mbps networks and above 50 on 100Mbps networks. The number of parallel downloads remains constrained under the maximum defined by the --max-concurrent-downloads parameter. Default: false
  final Aria2ConcurrentOptimizer? optimizeConcurrentDownloads;

  /// Save Cookies to FILE in Mozilla/Firefox(1.x/2.x)/ Netscape format. If FILE already exists, it is overwritten. Session Cookies are also saved and their expiry values are treated as 0. Possible Values: /path/to/file
  final String? saveCookies;

  /// Save error/unfinished downloads to FILE on exit. You can pass this output file to aria2c with --input-file option on restart. If you like the output to be gzipped append a .gz extension to the file name. Please note that downloads added by aria2.addTorrent() and aria2.addMetalink() RPC method and whose metadata could not be saved as a file are not saved. Downloads removed using aria2.remove() and aria2.forceRemove() will not be saved. GID is also saved with gid, but there are some restrictions, see below.
  /// Note
  /// Normally, GID of the download itself is saved. But some downloads use metadata (e.g., BitTorrent and Metalink). In this case, there are some restrictions.
  /// magnet URI, and followed by torrent download
  /// GID of BitTorrent metadata download is saved.
  /// URI to torrent file, and followed by torrent download
  /// GID of torrent file download is saved.
  /// URI to metalink file, and followed by file downloads described in metalink file
  /// GID of metalink file download is saved.
  /// local torrent file
  /// GID of torrent download is saved.
  /// local metalink file
  /// Any meaningful GID is not saved.
  final String? saveSession;

  /// Specify the file name to which performance profile of the servers is saved. You can load saved data using --server-stat-if option. See Server Performance Profile subsection below for file format.
  final String? serverStatOf;

  const Aria2OptionObject({
    super.allProxy,
    super.allProxyPasswd,
    super.allProxyUser,
    super.allowOverwrite,
    super.allowPieceLengthChange,
    super.alwaysResume,
    super.asyncDns,
    super.autoFileRenaming,
    super.btEnableHookAfterHashCheck,
    super.btEnableLpd,
    super.btExcludeTracker,
    super.btExternalIP,
    super.btForceEncryption,
    super.btHashCheckSeed,
    super.btLoadSavedMetadata,
    super.btMaxPeers,
    super.btMetadataOnly,
    super.btMinCryptoLevel,
    super.btPrioritizePiece,
    super.btRemoveUnselectedFile,
    super.btRequestPeerSpeedLimit,
    super.btRequireCrypto,
    super.btSaveMetadata,
    super.btSeedUnverified,
    super.btStopTimeout,
    super.btTracker,
    super.btTrackerConnectTimeout,
    super.btTrackerInterval,
    super.btTrackerTimeout,
    super.checkIntegrity,
    super.checksum,
    super.conditionalGet,
    super.connectTimeout,
    super.contentDispositionDefaultUtf8,
    super.aria2Continue,
    super.dir,
    // super.dryRun,
    super.enableHttpKeepAlive,
    super.enableHttpPipelining,
    super.enableMmap,
    super.enablePeerExchange,
    super.fileAllocation,
    super.followMetalink,
    super.followTorrent,
    super.forceSave,
    super.ftpPasswd,
    super.ftpPasv,
    super.ftpProxy,
    super.ftpProxyPasswd,
    super.ftpProxyUser,
    super.ftpReuseConnection,
    super.ftpType,
    super.ftpUser,
    super.gid,
    super.hashCheckOnly,
    super.header,
    super.httpAcceptGzip,
    super.httpAuthChallenge,
    super.httpNoCache,
    super.httpPasswd,
    super.httpProxy,
    super.httpProxyPasswd,
    super.httpProxyUser,
    super.httpUser,
    super.httpsProxy,
    super.httpsProxyPasswd,
    super.httpsProxyUser,
    super.indexOut,
    super.lowestSpeedLimit,
    super.maxConnectionPerServer,
    super.maxDownloadLimit,
    super.maxFileNotFound,
    super.maxMmapLimit,
    super.maxResumeFailureTries,
    super.maxTries,
    super.maxUploadLimit,
    // super.metalinkBaseUri,
    super.metalinkEnableUniqueProtocol,
    super.metalinkLanguage,
    super.metalinkLocation,
    super.metalinkOS,
    super.metalinkPreferredProtocol,
    super.metalinkVersion,
    super.minSplitSize,
    super.noFileAllocationLimit,
    super.noNetrc,
    super.noProxy,
    super.out,
    // super.parameterizedUri,
    // super.pause,
    super.pauseMetadata,
    // super.pieceLength,
    super.proxyMethod,
    super.realtimeChunkChecksum,
    super.referer,
    super.remoteTime,
    super.removeControlFile,
    super.retryWait,
    super.reuseUri,
    // super.rpcSaveUploadMetadata,
    super.seedRatio,
    super.seedTime,
    super.selectFile,
    super.split,
    super.sshHostKeyMd,
    super.streamPieceSelector,
    super.timeout,
    super.uriSelector,
    super.useHead,
    super.userAgent,
  }) : btMaxOpenFiles = null,
       downloadResult = null,
       keepUnfinishedDownloadResult = null,
       log = null,
       logLevel = null,
       maxConcurrentDownloads = null,
       maxDownloadResult = null,
       maxOverallDownloadLimit = null,
       maxOverallUploadLimit = null,
       optimizeConcurrentDownloads = null,
       saveCookies = null,
       saveSession = null,
       serverStatOf = null;

  Aria2OptionObject.fromJson(Map<String, dynamic> json)
    : btMaxOpenFiles = _buildConversion(
        json['bt-max-open-files'],
        (e) => int.parse(e),
      ),
      downloadResult = _buildConversion(
        json['download-result'],
        (e) => Aria2DownloadResult.values.byAlias(e),
      ),
      keepUnfinishedDownloadResult = _buildConversion(
        json['keep-unfinished-download-result'],
        (e) => bool.parse(e),
      ),
      log = json['log'],
      logLevel = _buildConversion(
        json['log-level'],
        (e) => Aria2LogLevel.values.byName(e),
      ),
      maxConcurrentDownloads = _buildConversion(
        json['max-concurrent-downloads'],
        (e) => int.parse(e),
      ),
      maxDownloadResult = _buildConversion(
        json['max-download-result'],
        (e) => int.parse(e),
      ),
      maxOverallDownloadLimit = json['max-overall-download-limit'],
      maxOverallUploadLimit = json['max-overall-upload-limit'],
      optimizeConcurrentDownloads = _buildConversion(
        json['optimize-concurrent-downloads'],
        (e) => Aria2ConcurrentOptimizer.fromType(e),
      ),
      saveCookies = json['save-cookies'],
      saveSession = json['save-session'],
      serverStatOf = json['server-stat-of'],
      super(
        allProxy: json['all-proxy'],
        allProxyPasswd: json['all-proxy-passwd'],
        allProxyUser: json['all-proxy-user'],
        allowOverwrite: _buildConversion(
          json['allow-overwrite'],
          (e) => bool.parse(e),
        ),
        allowPieceLengthChange: _buildConversion(
          json['allow-piece-length-change'],
          (e) => bool.parse(e),
        ),
        alwaysResume: _buildConversion(
          json['always-resume'],
          (e) => bool.parse(e),
        ),
        asyncDns: _buildConversion(json['async-dns'], (e) => bool.parse(e)),
        autoFileRenaming: _buildConversion(
          json['auto-file-renaming'],
          (e) => bool.parse(e),
        ),
        btEnableHookAfterHashCheck: _buildConversion(
          json['bt-enable-hook-after-hash-check'],
          (e) => bool.parse(e),
        ),
        btEnableLpd: _buildConversion(
          json['bt-enable-lpd'],
          (e) => bool.parse(e),
        ),
        btExcludeTracker: json['bt-exclude-tracker'],
        btExternalIP: json['bt-external-ip'],
        btForceEncryption: _buildConversion(
          json['bt-force-encryption'],
          (e) => bool.parse(e),
        ),
        btHashCheckSeed: _buildConversion(
          json['bt-hash-check-seed'],
          (e) => bool.parse(e),
        ),
        btLoadSavedMetadata: _buildConversion(
          json['bt-load-saved-metadata'],
          (e) => bool.parse(e),
        ),
        btMaxPeers: _buildConversion(json['bt-max-peers'], (e) => int.parse(e)),
        btMetadataOnly: _buildConversion(
          json['bt-metadata-only'],
          (e) => bool.parse(e),
        ),
        btMinCryptoLevel: _buildConversion(
          json['bt-min-crypto-level'],
          (e) => Aria2BtCryptoLevel.values.byName(e),
        ),
        btPrioritizePiece: _buildConversion(
          json['bt-prioritize-piece'],
          (e) => Aria2BtPrioritizePieceOption.fromMap(e),
        ),
        btRemoveUnselectedFile: _buildConversion(
          json['bt-remove-unselected-file'],
          (e) => bool.parse(e),
        ),
        btRequestPeerSpeedLimit: json['bt-request-peer-speed-limit'],
        btRequireCrypto: _buildConversion(
          json['bt-require-crypto'],
          (e) => bool.parse(e),
        ),
        btSaveMetadata: _buildConversion(
          json['bt-save-metadata'],
          (e) => bool.parse(e),
        ),
        btSeedUnverified: _buildConversion(
          json['bt-seed-unverified'],
          (e) => bool.parse(e),
        ),
        btStopTimeout: _buildConversion(
          json['bt-stop-timeout'],
          (e) => int.parse(e),
        ),
        btTracker: (json['bt-tracker'] as String?)?.split(','),
        btTrackerConnectTimeout: _buildConversion(
          json['bt-tracker-connect-timeout'],
          (e) => int.parse(e),
        ),
        btTrackerInterval: _buildConversion(
          json['bt-tracker-interval'],
          (e) => int.parse(e),
        ),
        btTrackerTimeout: _buildConversion(
          json['bt-tracker-timeout'],
          (e) => int.parse(e),
        ),
        checkIntegrity: _buildConversion(
          json['check-integrity'],
          (e) => bool.parse(e),
        ),
        checksum: _buildConversion(
          json['checksum'],
          (e) => Aria2HashOption.fromMap(e),
        ),
        conditionalGet: _buildConversion(
          json['conditional-get'],
          (e) => bool.parse(e),
        ),
        connectTimeout: _buildConversion(
          json['connect-timeout'],
          (e) => int.parse(e),
        ),
        contentDispositionDefaultUtf8: _buildConversion(
          json['content-disposition-default-utf8'],
          (e) => bool.parse(e),
        ),
        aria2Continue: _buildConversion(json['continue'], (e) => bool.parse(e)),
        dir: json['dir'],
        dryRun: _buildConversion(json['dry-run'], (e) => bool.parse(e)),
        enableHttpKeepAlive: _buildConversion(
          json['enable-http-keep-alive'],
          (e) => bool.parse(e),
        ),
        enableHttpPipelining: _buildConversion(
          json['enable-http-pipelining'],
          (e) => bool.parse(e),
        ),
        enableMmap: _buildConversion(json['enable-mmap'], (e) => bool.parse(e)),
        enablePeerExchange: _buildConversion(
          json['enable-peer-exchange'],
          (e) => bool.parse(e),
        ),
        fileAllocation: _buildConversion(
          json['file-allocation'],
          (e) => Aria2FileAllocationMethod.values.byName(e),
        ),
        followMetalink: _buildConversion(
          json['follow-metalink'],
          (e) => Aria2Symbol.values.byAlias(e),
        ),
        followTorrent: _buildConversion(
          json['follow-torrent'],
          (e) => Aria2Symbol.values.byAlias(e),
        ),
        forceSave: _buildConversion(json['force-save'], (e) => bool.parse(e)),
        ftpPasswd: json['ftp-passwd'],
        ftpPasv: _buildConversion(json['ftp-pasv'], (e) => bool.parse(e)),
        ftpProxy: json['ftp-proxy'],
        ftpProxyPasswd: json['ftp-proxy-passwd'],
        ftpProxyUser: json['ftp-proxy-user'],
        ftpReuseConnection: _buildConversion(
          json['ftp-reuse-connection'],
          (e) => bool.parse(e),
        ),
        ftpType: _buildConversion(
          json['ftp-type'],
          (e) => Aria2FTPType.values.byName(e),
        ),
        ftpUser: json['ftp-user'],
        gid: json['gid'],
        hashCheckOnly: _buildConversion(
          json['hash-check-only'],
          (e) => bool.parse(e),
        ),
        header: json['header'],
        httpAcceptGzip: _buildConversion(
          json['http-accept-gzip'],
          (e) => bool.parse(e),
        ),
        httpAuthChallenge: _buildConversion(
          json['http-auth-challenge'],
          (e) => bool.parse(e),
        ),
        httpNoCache: _buildConversion(
          json['http-no-cache'],
          (e) => bool.parse(e),
        ),
        httpPasswd: json['http-passwd'],
        httpProxy: json['http-proxy'],
        httpProxyPasswd: json['http-proxy-passwd'],
        httpProxyUser: json['http-proxy-user'],
        httpUser: json['http-user'],
        httpsProxy: json['https-proxy'],
        httpsProxyPasswd: json['https-proxy-passwd'],
        httpsProxyUser: json['https-proxy-user'],
        indexOut: json['index-out'],
        lowestSpeedLimit: json['lowest-speed-limit'],
        maxConnectionPerServer: _buildConversion(
          json['max-connection-per-server'],
          (e) => int.parse(e),
        ),
        maxDownloadLimit: json['max-download-limit'],
        maxFileNotFound: _buildConversion(
          json['max-file-not-found'],
          (e) => int.parse(e),
        ),
        maxMmapLimit: json['max-mmap-limit'],
        maxResumeFailureTries: _buildConversion(
          json['max-resume-failure-tries'],
          (e) => int.parse(e),
        ),
        maxTries: _buildConversion(json['max-tries'], (e) => int.parse(e)),
        maxUploadLimit: json['max-upload-limit'],
        metalinkBaseUri: json['metalink-base-uri'],
        metalinkEnableUniqueProtocol: _buildConversion(
          json['metalink-enable-unique-protocol'],
          (e) => bool.parse(e),
        ),
        metalinkLanguage: json['metalink-language'],
        metalinkLocation: json['metalink-location'],
        metalinkOS: json['metalink-os'],
        metalinkPreferredProtocol: _buildConversion(
          json['metalink-preferred-protocol'],
          (e) => Aria2MetalinkPreferredProtocol.values.byName(e),
        ),
        metalinkVersion: json['metalink-version'],
        minSplitSize: json['min-split-size'],
        noFileAllocationLimit: json['no-file-allocation-limit'],
        noNetrc: _buildConversion(json['no-netrc'], (e) => bool.parse(e)),
        noProxy: json['no-proxy'],
        out: json['out'],
        parameterizedUri: _buildConversion(
          json['parameterized-uri'],
          (e) => bool.parse(e),
        ),
        pause: _buildConversion(json['pause'], (e) => bool.parse(e)),
        pauseMetadata: _buildConversion(
          json['pause-metadata'],
          (e) => bool.parse(e),
        ),
        pieceLength: json['piece-length'],
        proxyMethod: _buildConversion(
          json['proxy-method'],
          (e) => Aria2ProxyMethod.values.byName(e),
        ),
        realtimeChunkChecksum: _buildConversion(
          json['realtime-chunk-checksum'],
          (e) => bool.parse(e),
        ),
        referer: json['referer'],
        remoteTime: _buildConversion(json['remote-time'], (e) => bool.parse(e)),
        removeControlFile: _buildConversion(
          json['remove-control-file'],
          (e) => bool.parse(e),
        ),
        retryWait: _buildConversion(json['retry-wait'], (e) => int.parse(e)),
        reuseUri: _buildConversion(json['reuse-uri'], (e) => bool.parse(e)),
        rpcSaveUploadMetadata: _buildConversion(
          json['rpc-save-upload-metadata'],
          (e) => bool.parse(e),
        ),
        seedRatio: _buildConversion(json['seed-ratio'], (e) => double.parse(e)),
        seedTime: _buildConversion(json['seed-time'], (e) => double.parse(e)),
        selectFile: json['select-file'],
        split: _buildConversion(json['split'], (e) => int.parse(e)),
        sshHostKeyMd: _buildConversion(
          json['ssh-host-key-md'],
          (e) => Aria2HashOption.fromMap(e),
        ),
        streamPieceSelector: _buildConversion(
          json['stream-piece-selector'],
          (e) => Aria2StreamPieceSelector.values.byAlias(e),
        ),
        timeout: _buildConversion(json['timeout'], (e) => int.parse(e)),
        uriSelector: _buildConversion(
          json['uri-selector'],
          (e) => Aria2UriSelector.values.byName(e),
        ),
        useHead: _buildConversion(json['use-head'], (e) => bool.parse(e)),
        userAgent: json['user-agent'],
      );

  const Aria2OptionObject.global({
    super.allProxy,
    super.allProxyPasswd,
    super.allProxyUser,
    super.allowOverwrite,
    super.allowPieceLengthChange,
    super.alwaysResume,
    super.asyncDns,
    super.autoFileRenaming,
    super.btEnableHookAfterHashCheck,
    super.btEnableLpd,
    super.btExcludeTracker,
    super.btExternalIP,
    super.btForceEncryption,
    super.btHashCheckSeed,
    super.btLoadSavedMetadata,
    super.btMaxPeers,
    super.btMetadataOnly,
    super.btMinCryptoLevel,
    super.btPrioritizePiece,
    super.btRemoveUnselectedFile,
    super.btRequestPeerSpeedLimit,
    super.btRequireCrypto,
    super.btSaveMetadata,
    super.btSeedUnverified,
    super.btStopTimeout,
    super.btTracker,
    super.btTrackerConnectTimeout,
    super.btTrackerInterval,
    super.btTrackerTimeout,
    super.checkIntegrity,
    // super.checksum,
    super.conditionalGet,
    super.connectTimeout,
    super.contentDispositionDefaultUtf8,
    super.aria2Continue,
    super.dir,
    super.dryRun,
    super.enableHttpKeepAlive,
    super.enableHttpPipelining,
    super.enableMmap,
    super.enablePeerExchange,
    super.fileAllocation,
    super.followMetalink,
    super.followTorrent,
    super.forceSave,
    super.ftpPasswd,
    super.ftpPasv,
    super.ftpProxy,
    super.ftpProxyPasswd,
    super.ftpProxyUser,
    super.ftpReuseConnection,
    super.ftpType,
    super.ftpUser,
    super.gid,
    super.hashCheckOnly,
    super.header,
    super.httpAcceptGzip,
    super.httpAuthChallenge,
    super.httpNoCache,
    super.httpPasswd,
    super.httpProxy,
    super.httpProxyPasswd,
    super.httpProxyUser,
    super.httpUser,
    super.httpsProxy,
    super.httpsProxyPasswd,
    super.httpsProxyUser,
    // super.indexOut,
    super.lowestSpeedLimit,
    super.maxConnectionPerServer,
    super.maxDownloadLimit,
    super.maxFileNotFound,
    super.maxMmapLimit,
    super.maxResumeFailureTries,
    super.maxTries,
    super.maxUploadLimit,
    super.metalinkBaseUri,
    super.metalinkEnableUniqueProtocol,
    super.metalinkLanguage,
    super.metalinkLocation,
    super.metalinkOS,
    super.metalinkPreferredProtocol,
    super.metalinkVersion,
    super.minSplitSize,
    super.noFileAllocationLimit,
    super.noNetrc,
    super.noProxy,
    // super.out,
    super.parameterizedUri,
    // super.pause,
    super.pauseMetadata,
    super.pieceLength,
    super.proxyMethod,
    super.realtimeChunkChecksum,
    super.referer,
    super.remoteTime,
    super.removeControlFile,
    super.retryWait,
    super.reuseUri,
    super.rpcSaveUploadMetadata,
    super.seedRatio,
    super.seedTime,
    // super.selectFile,
    super.split,
    super.sshHostKeyMd,
    super.streamPieceSelector,
    super.timeout,
    super.uriSelector,
    super.useHead,
    super.userAgent,
    this.btMaxOpenFiles,
    this.downloadResult,
    this.keepUnfinishedDownloadResult,
    this.log,
    this.logLevel,
    this.maxConcurrentDownloads,
    this.maxDownloadResult,
    this.maxOverallDownloadLimit,
    this.maxOverallUploadLimit,
    this.optimizeConcurrentDownloads,
    this.saveCookies,
    this.saveSession,
    this.serverStatOf,
  });

  @override
  Map<String, dynamic> get parametrized {
    final result = <String, dynamic>{};

    if (allProxy != null) result['all-proxy'] = allProxy;
    if (allProxyPasswd != null) result['all-proxy-passwd'] = allProxyPasswd;
    if (allProxyUser != null) result['all-proxy-user'] = allProxyUser;
    if (allowOverwrite != null) result['allow-overwrite'] = allowOverwrite;
    if (allowPieceLengthChange != null) {
      result['allow-piece-length-change'] = allowPieceLengthChange;
    }
    if (alwaysResume != null) result['always-resume'] = alwaysResume;
    if (asyncDns != null) result['async-dns'] = asyncDns;
    if (autoFileRenaming != null) {
      result['auto-file-renaming'] = autoFileRenaming;
    }
    if (btEnableHookAfterHashCheck != null) {
      result['bt-enable-hook-after-hash-check'] = btEnableHookAfterHashCheck;
    }
    if (btEnableLpd != null) result['bt-enable-lpd'] = btEnableLpd;
    if (btExcludeTracker != null) {
      result['bt-exclude-tracker'] = btExcludeTracker;
    }
    if (btExternalIP != null) result['bt-external-ip'] = btExternalIP;
    if (btForceEncryption != null) {
      result['bt-force-encryption'] = btForceEncryption;
    }
    if (btHashCheckSeed != null) result['bt-hash-check-seed'] = btHashCheckSeed;
    if (btLoadSavedMetadata != null) {
      result['bt-load-saved-metadata'] = btLoadSavedMetadata;
    }
    if (btMaxPeers != null) result['bt-max-peers'] = btMaxPeers;
    if (btMetadataOnly != null) result['bt-metadata-only'] = btMetadataOnly;
    if (btMinCryptoLevel != null) {
      result['bt-min-crypto-level'] = btMinCryptoLevel!.name;
    }
    if (btPrioritizePiece != null) {
      result['bt-prioritize-piece'] = btPrioritizePiece!.toString();
    }
    if (btRemoveUnselectedFile != null) {
      result['bt-remove-unselected-file'] = btRemoveUnselectedFile;
    }
    if (btRequestPeerSpeedLimit != null) {
      result['bt-request-peer-speed-limit'] = btRequestPeerSpeedLimit;
    }
    if (btRequireCrypto != null) result['bt-require-crypto'] = btRequireCrypto;
    if (btSaveMetadata != null) result['bt-save-metadata'] = btSaveMetadata;
    if (btSeedUnverified != null) {
      result['bt-seed-unverified'] = btSeedUnverified;
    }
    if (btStopTimeout != null) result['bt-stop-timeout'] = btStopTimeout;
    if (btTracker != null) result['bt-tracker'] = btTracker;
    if (btTrackerConnectTimeout != null) {
      result['bt-tracker-connect-timeout'] = btTrackerConnectTimeout;
    }
    if (btTrackerInterval != null) {
      result['bt-tracker-interval'] = btTrackerInterval;
    }
    if (btTrackerTimeout != null) {
      result['bt-tracker-timeout'] = btTrackerTimeout;
    }
    if (checkIntegrity != null) result['check-integrity'] = checkIntegrity;
    if (checksum != null) result['checksum'] = checksum.toString();
    if (conditionalGet != null) result['conditional-get'] = conditionalGet;
    if (connectTimeout != null) result['connect-timeout'] = connectTimeout;
    if (contentDispositionDefaultUtf8 != null) {
      result['content-disposition-default-utf8'] =
          contentDispositionDefaultUtf8;
    }
    if (aria2Continue != null) result['continue'] = aria2Continue;
    if (dir != null) result['dir'] = dir;
    if (dryRun != null) result['dry-run'] = dryRun;
    if (enableHttpKeepAlive != null) {
      result['enable-http-keep-alive'] = enableHttpKeepAlive;
    }
    if (enableHttpPipelining != null) {
      result['enable-http-pipelining'] = enableHttpPipelining;
    }
    if (enableMmap != null) result['enable-mmap'] = enableMmap;
    if (enablePeerExchange != null) {
      result['enable-peer-exchange'] = enablePeerExchange;
    }
    if (fileAllocation != null) {
      result['file-allocation'] = fileAllocation!.name;
    }
    if (followMetalink != null) {
      result['follow-metalink'] = followMetalink!.name;
    }
    if (followTorrent != null) result['follow-torrent'] = followTorrent!.name;
    if (forceSave != null) result['force-save'] = forceSave;
    if (ftpPasswd != null) result['ftp-passwd'] = ftpPasswd;
    if (ftpPasv != null) result['ftp-pasv'] = ftpPasv;
    if (ftpProxy != null) result['ftp-proxy'] = ftpProxy;
    if (ftpProxyPasswd != null) result['ftp-proxy-passwd'] = ftpProxyPasswd;
    if (ftpProxyUser != null) result['ftp-proxy-user'] = ftpProxyUser;
    if (ftpReuseConnection != null) {
      result['ftp-reuse-connection'] = ftpReuseConnection;
    }
    if (ftpType != null) result['ftp-type'] = ftpType!.name;
    if (ftpUser != null) result['ftp-user'] = ftpUser;
    if (gid != null) result['gid'] = gid;
    if (hashCheckOnly != null) result['hash-check-only'] = hashCheckOnly;
    if (header != null) result['header'] = header;
    if (httpAcceptGzip != null) result['http-accept-gzip'] = httpAcceptGzip;
    if (httpAuthChallenge != null) {
      result['http-auth-challenge'] = httpAuthChallenge;
    }
    if (httpNoCache != null) result['http-no-cache'] = httpNoCache;
    if (httpPasswd != null) result['http-passwd'] = httpPasswd;
    if (httpProxy != null) result['http-proxy'] = httpProxy;
    if (httpProxyPasswd != null) result['http-proxy-passwd'] = httpProxyPasswd;
    if (httpProxyUser != null) result['http-proxy-user'] = httpProxyUser;
    if (httpUser != null) result['http-user'] = httpUser;
    if (httpsProxy != null) result['https-proxy'] = httpsProxy;
    if (httpsProxyPasswd != null) {
      result['https-proxy-passwd'] = httpsProxyPasswd;
    }
    if (httpsProxyUser != null) result['https-proxy-user'] = httpsProxyUser;
    if (indexOut != null) result['index-out'] = indexOut;
    if (lowestSpeedLimit != null) {
      result['lowest-speed-limit'] = lowestSpeedLimit;
    }
    if (maxConnectionPerServer != null) {
      result['max-connection-per-server'] = maxConnectionPerServer;
    }
    if (maxDownloadLimit != null) {
      result['max-download-limit'] = maxDownloadLimit;
    }
    if (maxFileNotFound != null) result['max-file-not-found'] = maxFileNotFound;
    if (maxMmapLimit != null) result['max-mmap-limit'] = maxMmapLimit;
    if (maxResumeFailureTries != null) {
      result['max-resume-failure-tries'] = maxResumeFailureTries;
    }
    if (maxTries != null) result['max-tries'] = maxTries;
    if (maxUploadLimit != null) result['max-upload-limit'] = maxUploadLimit;
    if (metalinkBaseUri != null) result['metalink-base-uri'] = metalinkBaseUri;
    if (metalinkEnableUniqueProtocol != null) {
      result['metalink-enable-unique-protocol'] = metalinkEnableUniqueProtocol;
    }
    if (metalinkLanguage != null) {
      result['metalink-language'] = metalinkLanguage;
    }
    if (metalinkLocation != null) {
      result['metalink-location'] = metalinkLocation;
    }
    if (metalinkOS != null) result['metalink-os'] = metalinkOS;
    if (metalinkPreferredProtocol != null) {
      result['metalink-preferred-protocol'] = metalinkPreferredProtocol!.name;
    }
    if (metalinkVersion != null) result['metalink-version'] = metalinkVersion;
    if (minSplitSize != null) result['min-split-size'] = minSplitSize;
    if (noFileAllocationLimit != null) {
      result['no-file-allocation-limit'] = noFileAllocationLimit;
    }
    if (noNetrc != null) result['no-netrc'] = noNetrc;
    if (noProxy != null) result['no-proxy'] = noProxy;
    if (out != null) result['out'] = out;
    if (parameterizedUri != null) {
      result['parameterized-uri'] = parameterizedUri;
    }
    if (pause != null) result['pause'] = pause;
    if (pauseMetadata != null) result['pause-metadata'] = pauseMetadata;
    if (pieceLength != null) result['piece-length'] = pieceLength;
    if (proxyMethod != null) result['proxy-method'] = proxyMethod;
    if (realtimeChunkChecksum != null) {
      result['realtime-chunk-checksum'] = realtimeChunkChecksum;
    }
    if (referer != null) result['referer'] = referer;
    if (remoteTime != null) result['remote-time'] = remoteTime;
    if (removeControlFile != null) {
      result['remove-control-file'] = removeControlFile;
    }
    if (retryWait != null) result['retry-wait'] = retryWait;
    if (reuseUri != null) result['reuse-uri'] = reuseUri;
    if (rpcSaveUploadMetadata != null) {
      result['rpc-save-upload-metadata'] = rpcSaveUploadMetadata;
    }
    if (seedRatio != null) result['seed-ratio'] = seedRatio;
    if (seedTime != null) result['seed-time'] = seedTime;
    if (selectFile != null) result['select-file'] = selectFile;
    if (split != null) result['split'] = split;
    if (sshHostKeyMd != null) {
      result['ssh-host-key-md'] = sshHostKeyMd!.toString();
    }
    if (streamPieceSelector != null) {
      result['stream-piece-selector'] = streamPieceSelector!.alias;
    }
    if (timeout != null) result['timeout'] = timeout;
    if (uriSelector != null) result['uri-selector'] = uriSelector!.name;
    if (useHead != null) result['use-head'] = useHead;
    if (userAgent != null) result['user-agent'] = userAgent;
    if (btMaxOpenFiles != null) {
      result['bt-max-open-files'] = btMaxOpenFiles;
    }
    if (downloadResult != null) {
      result['download-result'] = downloadResult.toString();
    }
    if (keepUnfinishedDownloadResult != null) {
      result['keep-unfinished-download-result'] = keepUnfinishedDownloadResult;
    }
    if (log != null) result['log'] = log;
    if (logLevel != null) result['log-level'] = logLevel?.name;
    if (maxConcurrentDownloads != null) {
      result['max-concurrent-downloads'] = maxConcurrentDownloads;
    }
    if (maxDownloadResult != null) {
      result['max-download-result'] = maxDownloadResult;
    }
    if (maxOverallDownloadLimit != null) {
      result['max-overall-download-limit'] = maxOverallDownloadLimit;
    }
    if (maxOverallUploadLimit != null) {
      result['max-overall-upload-limit'] = maxOverallUploadLimit;
    }
    if (optimizeConcurrentDownloads != null) {
      result['optimize-concurrent-downloads'] = optimizeConcurrentDownloads
          .toString();
    }
    if (saveCookies != null) result['save-cookies'] = saveCookies;
    if (saveSession != null) result['save-session'] = saveSession;
    if (serverStatOf != null) result['server-stat-of'] = serverStatOf;

    return result;
  }

  static bool _anyKeyMatch(Set<String> keySet) {
    return keySet.any(
      (e) => const {
        'all-proxy',
        'all-proxy-passwd',
        'all-proxy-user',
        'allow-overwrite',
        'allow-piece-length-change',
        'always-resume',
        'async-dns',
        'auto-file-renaming',
        'bt-enable-hook-after-hash-check',
        'bt-enable-lpd',
        'bt-exclude-tracker',
        'bt-external-ip',
        'bt-force-encryption',
        'bt-hash-check-seed',
        'bt-load-saved-metadata',
        'bt-max-peers',
        'bt-metadata-only',
        'bt-min-crypto-level',
        'bt-prioritize-piece',
        'bt-remove-unselected-file',
        'bt-request-peer-speed-limit',
        'bt-require-crypto',
        'bt-save-metadata',
        'bt-seed-unverified',
        'bt-stop-timeout',
        'bt-tracker',
        'bt-tracker-connect-timeout',
        'bt-tracker-interval',
        'bt-tracker-timeout',
        'check-integrity',
        'checksum',
        'conditional-get',
        'connect-timeout',
        'content-disposition-default-utf8',
        'continue',
        'dir',
        'dry-run',
        'enable-http-keep-alive',
        'enable-http-pipelining',
        'enable-mmap',
        'enable-peer-exchange',
        'file-allocation',
        'follow-metalink',
        'follow-torrent',
        'force-save',
        'ftp-passwd',
        'ftp-pasv',
        'ftp-proxy',
        'ftp-proxy-passwd',
        'ftp-proxy-user',
        'ftp-reuse-connection',
        'ftp-type',
        'ftp-user',
        'gid',
        'hash-check-only',
        'header',
        'http-accept-gzip',
        'http-auth-challenge',
        'http-no-cache',
        'http-passwd',
        'http-proxy',
        'http-proxy-passwd',
        'http-proxy-user',
        'http-user',
        'https-proxy',
        'https-proxy-passwd',
        'https-proxy-user',
        'index-out',
        'lowest-speed-limit',
        'max-connection-per-server',
        'max-download-limit',
        'max-file-not-found',
        'max-mmap-limit',
        'max-resume-failure-tries',
        'max-tries',
        'max-upload-limit',
        'metalink-base-uri',
        'metalink-enable-unique-protocol',
        'metalink-language',
        'metalink-location',
        'metalink-os',
        'metalink-preferred-protocol',
        'metalink-version',
        'min-split-size',
        'no-file-allocation-limit',
        'no-netrc',
        'no-proxy',
        'out',
        'parameterized-uri',
        'pause',
        'pause-metadata',
        'piece-length',
        'proxy-method',
        'realtime-chunk-checksum',
        'referer',
        'remote-time',
        'remove-control-file',
        'retry-wait',
        'reuse-uri',
        'rpc-save-upload-metadata',
        'seed-ratio',
        'seed-time',
        'select-file',
        'split',
        'ssh-host-key-md',
        'stream-piece-selector',
        'timeout',
        'uri-selector',
        'use-head',
        'user-agent',
        'bt-max-open-files',
        'download-result',
        'keep-unfinished-download-result',
        'log',
        'log-level',
        'max-concurrent-downloads',
        'max-download-result',
        'max-overall-download-limit',
        'max-overall-upload-limit',
        'optimize-concurrent-downloads',
        'save-cookies',
        'save-session',
        'server-stat-of',
      }.contains(e),
    );
  }
}

sealed class Aria2Result {
  const Aria2Result();

  factory Aria2Result.build(Aria2Method method, dynamic json) {
    switch (json) {
      case String e:
        return Aria2StringResult(e);
      case int e:
        return Aria2IntegerResult(e);
      case Map<String, dynamic> e:
        final needsAlias = const {
          Aria2MethodName.tellStatus,
          Aria2MethodName.tellActive,
          Aria2MethodName.tellWaiting,
          Aria2MethodName.tellStopped,
        }.contains(method.methodName);
        // Aria2DownloadingStatusObject 和 Aria2OptionObject 有部分key重合，需要起一个别名
        if (needsAlias) {
          if (e.containsKey('gid')) e['gid_alias'] = e.remove('gid');
          if (e.containsKey('dir')) e['dir_alias'] = e.remove('dir');
        }
        return Aria2ObjectResult.build(e);
    }
    throw FormatException('Invalid Aria2 result structure', json);
  }
}

class Aria2SessionInfoObject extends Aria2ObjectResult {
  final String sessionId;

  const Aria2SessionInfoObject({required this.sessionId});

  Aria2SessionInfoObject.fromJson(Map<String, dynamic> json)
    : this(sessionId: json['sessionId']);

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..write('sessionId: $sessionId')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {'sessionId'});
  }
}

class Aria2StringResult extends Aria2Result {
  final String value;

  const Aria2StringResult(this.value);

  @override
  String toString() {
    return value;
  }
}

class Aria2VersionObject extends Aria2ObjectResult {
  final String version;
  final List<String> enabledFeatures;

  const Aria2VersionObject({
    required this.version,
    required this.enabledFeatures,
  });

  Aria2VersionObject.fromJson(Map<String, dynamic> json)
    : this(
        version: json['version'],
        enabledFeatures: (json['enabledFeatures'] as List).cast<String>(),
      );

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll([
            'version: $version',
            'enabledFeatures: $enabledFeatures',
          ], ', ')
          ..write(')'))
        .toString();
  }

  static bool _keyMatch(Set<String> keySet) {
    return _keyMatcher.equals(keySet, const {'version', 'enabledFeatures'});
  }
}

class Aria2NotificationObject {
  final String gid;

  Aria2NotificationObject({required this.gid});

  Aria2NotificationObject.fromJson(Map<String, dynamic> json)
    : this(gid: json['gid']);

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..write('gid: $gid')
          ..write(')'))
        .toString();
  }
}

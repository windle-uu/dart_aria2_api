import 'package:aria2_api/src/enum.dart';
import 'package:aria2_api/src/helper.dart';

class Aria2BitTorrentData {
  final List<String> announceList;
  final String comment;
  final int creationDate;
  final Aria2BitTorrentMode mode;
  final Aria2BitTorrentInfo info;

  const Aria2BitTorrentData({
    required this.announceList,
    required this.comment,
    required this.creationDate,
    required this.mode,
    required this.info,
  });

  Aria2BitTorrentData.fromMap(Map<String, dynamic> map)
    : this(
        announceList: map['announceList'],
        comment: map['comment'],
        creationDate: int.parse(map['creationDate']),
        mode: Aria2BitTorrentMode.values.byName(map['mode']),
        info: Aria2BitTorrentInfo.fromMap(map['info']),
      );
}

class Aria2BitTorrentInfo {
  final String name;

  const Aria2BitTorrentInfo({required this.name});

  Aria2BitTorrentInfo.fromMap(Map<String, dynamic> map)
    : this(name: map['name']);
}

class Aria2BtPrioritizePieceOption {
  final String? head;
  final String? tail;

  const Aria2BtPrioritizePieceOption({this.head, this.tail});

  Aria2BtPrioritizePieceOption.fromMap(Map<String, dynamic> map)
    : this(head: map['head'], tail: map['tail']);

  @override
  String toString() {
    final result = StringBuffer();
    result.write('head');
    if (head != null) result.write('=$head');
    result.write(',');
    result.write('tail');
    if (tail != null) result.write('=$tail');

    return result.toString();
  }
}

class Aria2ConcurrentOptimizer {
  final dynamic value;

  const Aria2ConcurrentOptimizer.bool({required bool value})
    : this._(value: value);

  const Aria2ConcurrentOptimizer.custom({required int a, required int b})
    : this._(value: '$a:$b');

  factory Aria2ConcurrentOptimizer.fromType(dynamic value) {
    final boolean = bool.tryParse(value);
    if (boolean != null) return Aria2ConcurrentOptimizer.bool(value: boolean);
    return Aria2ConcurrentOptimizer._(value: value);
  }

  const Aria2ConcurrentOptimizer._({required this.value});

  @override
  String toString() {
    return value.toString();
  }
}

class Aria2HashOption {
  final Aria2HashType type;
  final String digest;

  const Aria2HashOption({required this.type, required this.digest});

  Aria2HashOption.fromMap(Map<String, dynamic> map)
    : this(
        type: Aria2HashType.values.byAlias(map['type']),
        digest: map['digest'],
      );

  @override
  String toString() {
    return '${type.name}=$digest';
  }
}

class Aria2InputFileOption {
  /// Use a proxy server for all protocols. To override a previously defined proxy, use empty string.
  /// You also can override this setting and specify a proxy server for a particular protocol using [httpProxy],
  /// [httpsProxy] and [ftpProxy] options. This affects all downloads.
  /// The format of PROXY is `[http://][USER:PASSWORD@]HOST[:PORT]`.
  ///
  /// Note: If user and password are embedded in proxy URI and they are also specified by
  /// [httpProxyUser], [httpProxyPasswd], [httpsProxyUser], [httpsProxyPasswd],
  /// [ftpProxyUser], [ftpProxyPasswd], [allProxyUser], [allProxyPasswd]
  /// options, those specified later override prior options.
  ///
  /// For example, if you specified [httpProxyUser]: `myname`,
  /// [httpProxyPasswd]: `mypass` in aria2.conf and you specified [httpProxy]: `http://proxy`
  /// on the command-line, then you'd get HTTP proxy `http://proxy` with user `myname` and password `mypass`.
  ///
  /// Another example: if you specified on the command-line [httpProxy]: `http://user:pass@proxy`
  /// [httpProxyUser]: `myname` [httpProxyPasswd]: `mypass`,
  /// then you'd get HTTP proxy http://proxy with user `myname` and password `mypass`.
  ///
  /// One more example: if you specified in command-line [httpProxyUser]: `myname`
  /// [httpProxyPasswd]: `mypass` [httpProxy]: `http://user:pass@proxy`,
  /// then you'd get HTTP proxy http://proxy with user `user` and password `pass`.
  final String? allProxy;

  /// Set password for [allProxy] option.
  final String? allProxyPasswd;

  /// Set user for [allProxy] option.
  final String? allProxyUser;

  /// Restart download from scratch if the corresponding control file doesn't exist.
  /// See also [autoFileRenaming] option.
  ///
  /// Default: `false`
  final bool? allowOverwrite;

  /// If false is given, aria2 aborts download when a piece length is different from one in a control file.
  /// If true is given, you can proceed but some download progress will be lost.
  ///
  /// Default: `false`
  final bool? allowPieceLengthChange;

  /// Always resume download. If true is given, aria2 always tries to resume download and if resume is not possible,
  /// aborts download. If false is given, when all given URIs do not support resume or
  /// aria2 encounters N URIs which does not support resume (N is the value specified using [maxResumeFailureTries] option),
  /// aria2 downloads file from scratch. See [maxResumeFailureTries] option.
  ///
  /// Default: `true`
  final bool? alwaysResume;

  /// Enable asynchronous DNS.
  ///
  /// Default: `true`
  final bool? asyncDns;

  /// Rename file name if the same file already exists. This option works only in HTTP(S)/FTP download.
  /// The new file name has a dot and a number(1..9999) appended after the name, but before the file extension, if any.
  ///
  /// Default: `true`
  final bool? autoFileRenaming;

  /// Allow hook command invocation after hash check (see [checkIntegrity] option) in BitTorrent download.
  /// By default, when hash check succeeds, the command given by [onBtDownloadComplete] is executed.
  /// To disable this action, give false to this option.
  ///
  /// Default: `true`
  final bool? btEnableHookAfterHashCheck;

  /// Enable Local Peer Discovery. If a private flag is set in a torrent,
  /// aria2 doesn't use this feature for that download even if true is given.
  ///
  /// Default: `false`
  final bool? btEnableLpd;

  /// Comma separated list of BitTorrent tracker's announce URI to remove.
  /// You can use special value `*` which matches all URIs, thus removes all announce URIs.
  /// When specifying `*` in shell command-line, don't forget to escape or quote it. See also [btTracker] option.
  final List<String>? btExcludeTracker;

  /// Specify the external IP address to use in BitTorrent download and DHT.
  /// It may be sent to BitTorrent tracker. For DHT,
  /// this option should be set to report that local node is downloading a particular torrent.
  /// This is critical to use DHT in a private network. Although this function is named external,
  /// it can accept any kind of IP addresses.
  final String? btExternalIP;

  /// Requires BitTorrent message payload encryption with arc4.
  /// This is a shorthand of [btRequireCrypto]: `true`, [btMinCryptoLevel]: `Aria2BtCryptoLevel.arc4`.
  /// This option does not change the option value of those options. If true is given,
  /// deny legacy BitTorrent handshake and only use Obfuscation handshake and always encrypt message payload.
  ///
  /// Default: `false`
  final bool? btForceEncryption;

  /// If true is given, after hash check using [checkIntegrity] option and file is complete,
  /// continue to seed file. If you want to check file and download it only when it is damaged or incomplete,
  /// set this option to false. This option has effect only on BitTorrent download.
  ///
  /// Default: `true`
  final bool? btHashCheckSeed;

  /// Before getting torrent metadata from DHT when downloading with magnet link,
  /// first try to read file saved by [btSaveMetadata] option. If it is successful,
  /// then skip downloading metadata from DHT.
  ///
  /// Default: `false`
  final bool? btLoadSavedMetadata;

  /// Specify the maximum number of peers per torrent. `0` means unlimited. See also [btRequestPeerSpeedLimit] option.
  ///
  /// Default: `55`
  final int? btMaxPeers;

  /// Download metadata only. The file(s) described in metadata will not be downloaded.
  /// This option has effect only when BitTorrent Magnet URI is used. See also [btSaveMetadata] option.
  ///
  /// Default: `false`
  final bool? btMetadataOnly;

  /// Set minimum level of encryption method. If several encryption methods are provided by a peer,
  /// aria2 chooses the lowest one which satisfies the given level.
  ///
  /// Default: `Aria2BtCryptoLevel.plain`
  final Aria2BtCryptoLevel? btMinCryptoLevel;

  /// Try to download first and last pieces of each file first. This is useful for previewing files.
  /// The argument can contain 2 keywords: head and tail. To include both keywords, they must be separated by comma.
  /// These keywords can take one parameter, SIZE. For example, if head: &lt;SIZE&gt; is specified,
  /// pieces in the range of first SIZE bytes of each file get higher priority.
  /// tail: &lt;SIZE&gt; means the range of last SIZE bytes of each file. SIZE can include K or M (1K = 1024, 1M = 1024K).
  /// If SIZE is omitted, SIZE=1M is used.
  final Aria2BtPrioritizePieceOption? btPrioritizePiece;

  /// Removes the unselected files when download is completed in BitTorrent. To select files, use --select-file option.
  /// If it is not used, all files are assumed to be selected.
  /// Please use this option with care because it will actually remove files from your disk.
  ///
  /// Default: `false`
  final bool? btRemoveUnselectedFile;

  /// If the whole download speed of every torrent is lower than SPEED,
  /// aria2 temporarily increases the number of peers to try for more download speed.
  /// Configuring this option with your preferred download speed can increase your download speed in some cases.
  /// You can append K or M (1K = 1024, 1M = 1024K).
  ///
  /// Default: `50K`
  final String? btRequestPeerSpeedLimit;

  /// If true is given, aria2 doesn't accept and establish connection with legacy BitTorrent handshake(19BitTorrent protocol).
  /// Thus aria2 always uses Obfuscation handshake.
  ///
  /// Default: `false`
  final bool? btRequireCrypto;

  /// Save metadata as ".torrent" file. This option has effect only when BitTorrent Magnet URI is used.
  /// The file name is hex encoded info hash with suffix ".torrent".
  /// The directory to be saved is the same directory where download file is saved.
  /// If the same file already exists, metadata is not saved. See also [btMetadataOnly] option.
  ///
  /// Default: `false`
  final bool? btSaveMetadata;

  /// Seed previously downloaded files without verifying piece hashes.
  ///
  /// Default: `false`
  final bool? btSeedUnverified;

  /// Stop BitTorrent download if download speed is 0 in consecutive [btStopTimeout] seconds.
  /// If `0` is given, this feature is disabled.
  ///
  /// Default: `0`
  final int? btStopTimeout;

  /// Comma separated list of additional BitTorrent tracker's announce URI.
  /// These URIs are not affected by [btExcludeTracker] option because they are added after URIs in
  /// [btExcludeTracker] option are removed.
  final List<String>? btTracker;

  /// Set the connect timeout in seconds to establish connection to tracker.
  /// After the connection is established, this option makes no effect and [btTrackerTimeout] option is used instead.
  ///
  /// Default: `60`
  final int? btTrackerConnectTimeout;

  /// Set the interval in seconds between tracker requests.
  /// This completely overrides interval value and aria2 just uses this value and
  /// ignores the min interval and interval value in the response of tracker.
  /// If `0` is set, aria2 determines interval based on the response of tracker and the download progress.
  ///
  /// Default: `0`
  final int? btTrackerInterval;

  /// Set timeout in seconds.
  ///
  /// Default: `60`
  final int? btTrackerTimeout;

  /// Check file integrity by validating piece hashes or a hash of entire file.
  /// This option has effect only in BitTorrent, Metalink downloads with checksums or HTTP(S)/FTP downloads with [checksum] option.
  /// If piece hashes are provided, this option can detect damaged portions of a file and re-download them.
  /// If a hash of entire file is provided, hash check is only done when file has been already download.
  /// This is determined by file length. If hash check fails, file is re-downloaded from scratch.
  /// If both piece hashes and a hash of entire file are provided, only piece hashes are used.
  ///
  /// Default: `false`
  final bool? checkIntegrity;

  /// Set checksum. TYPE is hash type. The supported hash type is listed in Hash Algorithms in aria2c -v.
  /// DIGEST is hex digest. For example, setting sha-1 digest looks like this: sha-1=0192ba11326fe2298c8cb4de616f4d4140213838
  /// This option applies only to HTTP(S)/FTP downloads.
  final Aria2HashOption? checksum;

  /// Download file only when the local file is older than remote file. This function only works with HTTP(S) downloads only.
  /// It does not work if file size is specified in Metalink. It also ignores Content-Disposition header.
  /// If a control file exists, this option will be ignored.
  /// This function uses If-Modified-Since header to get only newer file conditionally.
  /// When getting modification time of local file,
  /// it uses user supplied file name (see [out] option) or file name part in URI if [out] is not specified.
  /// To overwrite existing file, [allowOverwrite] is required.
  ///
  /// Default: `false`
  final bool? conditionalGet;

  /// Set the connect timeout in seconds to establish connection to HTTP/FTP/proxy server.
  /// After the connection is established, this option makes no effect and [timeout] option is used instead.
  ///
  /// Default: `60`
  final int? connectTimeout;

  /// Handle quoted string in Content-Disposition header as UTF-8 instead of ISO-8859-1,
  /// for example, the filename parameter, but not the extended version filename*.
  ///
  /// Default: `false`
  final bool? contentDispositionDefaultUtf8;

  /// Continue downloading a partially downloaded file.
  /// Use this option to resume a download started by a web browser or
  /// another program which downloads files sequentially from the beginning.
  /// Currently this option is only applicable to HTTP(S)/FTP downloads.
  final bool? aria2Continue; // continue

  /// The directory to store the downloaded file.
  final String? dir;

  /// If `true` is given, aria2 just checks whether the remote file is available and doesn't download data.
  /// This option has effect on HTTP/FTP download. BitTorrent downloads are canceled if true is specified.
  ///
  /// Default: `false`
  final bool? dryRun;

  /// Enable HTTP/1.1 persistent connection.
  ///
  /// Default: `true`
  final bool? enableHttpKeepAlive;

  /// Enable HTTP/1.1 pipelining.
  ///
  /// Default: `false`
  final bool? enableHttpPipelining;

  /// Map files into memory. This option may not work if the file space is not pre-allocated. See [fileAllocation].
  ///
  /// Default: `false`
  final bool? enableMmap;

  /// Enable Peer Exchange extension. If a private flag is set in a torrent,
  /// this feature is disabled for that download even if true is given.
  ///
  /// Default: `true`
  final bool? enablePeerExchange;

  /// Specify file allocation method. none doesn't pre-allocate file space.
  /// `Aria2FileAllocationMethod.prealloc` pre-allocates file space before download begins. This may take some time depending on the size of the file.
  /// If you are using newer file systems such as ext4 (with extents support), btrfs, xfs or NTFS(MinGW build only),
  /// `Aria2FileAllocationMethod.falloc` is your best choice. It allocates large(few GiB) files almost instantly.
  /// Don't use `Aria2FileAllocationMethod.falloc` with legacy file systems such as ext3 and FAT32 because it takes almost the same time
  /// as `Aria2FileAllocationMethod.prealloc` and it blocks aria2 entirely until allocation finishes.
  /// `Aria2FileAllocationMethod.falloc` may not be available if your system doesn't have posix_fallocate(3) function.
  /// trunc uses ftruncate(2) system call or platform-specific counterpart to truncate a file to a specified length.
  ///
  /// Default: `Aria2FileAllocationMethod.prealloc`
  final Aria2FileAllocationMethod? fileAllocation;

  /// If `yes(true)` or `middle(mem)` is specified, when a file whose suffix is .meta4 or .metalink or
  /// content type of application/metalink4+xml or application/metalink+xml is downloaded,
  /// aria2 parses it as a metalink file and downloads files mentioned in it.
  /// If `middle(mem)` is specified, a metalink file is not written to the disk, but is just kept in memory.
  /// If `no(false)` is specified, the .metalink file is downloaded to the disk, but is not parsed as a metalink file and its contents are not downloaded.
  ///
  /// Default: `yes(true)`
  final Aria2Symbol? followMetalink;

  /// If `yes(true)` or `middle(mem)` is specified, when a file whose suffix is .torrent or
  /// content type is application/x-bittorrent is downloaded,
  /// aria2 parses it as a torrent file and downloads files mentioned in it.
  /// If `middle(mem)` is specified, a torrent file is not written to the disk, but is just kept in memory.
  /// If `no(false)` is specified, the .torrent file is downloaded to the disk,
  ///
  /// but is not parsed as a torrent and its contents are not downloaded.
  /// Default: `yes(true)`
  final Aria2Symbol? followTorrent;

  /// Save download with --save-session option even if the download is completed or removed.
  /// This option also saves control file in that situations.
  /// This may be useful to save BitTorrent seeding which is recognized as completed state.
  ///
  /// Default: false
  final bool? forceSave;

  /// Set FTP password. This affects all URIs. If user name is embedded but password is missing in URI,
  /// aria2 tries to resolve password using .netrc. If password is found in .netrc, then use it as password.
  /// If not, use the password specified in this option.
  ///
  /// Default: `ARIA2USER@`
  final String? ftpPasswd;

  /// Use the passive mode in FTP. If false is given, the active mode will be used.
  ///
  /// Note:
  /// This option is ignored for SFTP transfer.
  ///
  /// Default: `true`
  final bool? ftpPasv;

  /// Use a proxy server for FTP. To override a previously defined proxy, use empty string.
  /// See also the [allProxy] option. This affects all ftp downloads.
  /// The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT]
  final String? ftpProxy;

  /// Set password for [ftpProxy] option.
  final String? ftpProxyPasswd;

  /// Set user for [ftpProxy] option.
  final String? ftpProxyUser;

  /// Reuse connection in FTP.
  ///
  /// Default: `true`
  final bool? ftpReuseConnection;

  /// Set FTP transfer type. [ftpType] is either `Aria2FTPType.binary` or `Aria2FTPType.ascii`.
  /// Note:
  /// This option is ignored for SFTP transfer.
  ///
  /// Default: `Aria2FTPType.binary`
  final Aria2FTPType? ftpType;

  /// Set FTP user. This affects all URIs.
  ///
  /// Default: anonymous
  final String? ftpUser;

  /// Set GID manually. aria2 identifies each download by the ID called GID.
  /// The GID must be hex string of 16 characters, thus [0-9a-fA-F] are allowed and leading zeros must not be stripped.
  /// The GID all 0 is reserved and must not be used. The GID must be unique,
  /// otherwise error is reported and the download is not added.
  /// This option is useful when restoring the sessions saved using [saveSession] option.
  /// If this option is not used, new GID is generated by aria2.
  final String? gid;

  /// If `true` is given, after hash check using [checkIntegrity] option, abort download whether or not download is complete.
  ///
  /// Default: `false`
  final bool? hashCheckOnly;

  /// Append HEADER to HTTP request header. You can use this option repeatedly to specify more than one header:
  /// `aria2c --header="X-A: b78" --header="X-B: 9J1" "http://host/file"`
  final List<String>? header;

  /// Send `Accept-Encoding: deflate, gzip` request header and inflate response
  /// if remote server responds with `Content-Encoding: gzip` or `Content-Encoding: deflate`.
  ///
  /// Note:
  /// Some server responds with `Content-Encoding: gzip` for files which itself is gzipped file.
  /// aria2 inflates them anyway because of the response header.
  ///
  /// Default: `false`
  final bool? httpAcceptGzip;

  /// Send HTTP authorization header only when it is requested by the server.
  /// If `false` is set, then authorization header is always sent to the server.
  /// There is an exception: if user name and password are embedded in URI,
  /// authorization header is always sent to the server regardless of this option.
  ///
  /// Default: `false`
  final bool? httpAuthChallenge;

  /// Send `Cache-Control: no-cache` and `Pragma: no-cache` header to avoid cached content.
  /// If `false` is given, these headers are not sent and you can add Cache-Control header with
  /// a directive you like using [header] option.
  ///
  /// Default: `false`
  final bool? httpNoCache;

  /// Set HTTP password. This affects all URIs.
  final String? httpPasswd;

  /// Use a proxy server for HTTP. To override a previously defined proxy, use empty string.
  /// See also the [allProxy] option. This affects all http downloads.
  /// The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT]
  final String? httpProxy;

  /// Set password for [httpProxy].
  final String? httpProxyPasswd;

  /// Set user for [httpProxy].
  final String? httpProxyUser;

  /// Set HTTP user. This affects all URIs.
  final String? httpUser;

  /// Use a proxy server for HTTPS. To override a previously defined proxy, use empty string.
  /// See also the [allProxy] option. This affects all https download.
  /// The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT]
  final String? httpsProxy;

  /// Set password for [httpsProxy].
  final String? httpsProxyPasswd;

  /// Set user for [httpsProxy].
  final String? httpsProxyUser;

  /// Set file path for file with index=INDEX. You can find the file index using the [showFiles] option.
  /// PATH is a relative path to the path specified in [dir] option.
  /// You can use this option multiple times. Using this option,
  /// you can specify the output file names of BitTorrent downloads.
  final Map<int, String>? indexOut;

  /// Close connection if download speed is lower than or equal to this value(bytes per sec).
  /// `0` means aria2 does not have a lowest speed limit. You can append K or M (1K = 1024, 1M = 1024K).
  /// This option does not affect BitTorrent downloads.
  ///
  /// Default: `0`
  final String? lowestSpeedLimit;

  /// The maximum number of connections to one server for each download.
  ///
  /// Default: `1`
  final int? maxConnectionPerServer;

  /// Set max download speed per each download in bytes/sec. `0` means unrestricted.
  /// You can append K or M (1K = 1024, 1M = 1024K). To limit the overall download speed,
  /// use [maxOverallDownloadLimit] option.
  ///
  /// Default: `0`
  final String? maxDownloadLimit;

  /// If aria2 receives "file not found" status from the remote HTTP/FTP servers NUM times without getting a single byte,
  /// then force the download to fail. Specify 0 to disable this option.
  /// This options is effective only when using HTTP/FTP servers.
  /// The number of retry attempt is counted toward [maxTries], so it should be configured too.
  ///
  /// Default: `0`
  final int? maxFileNotFound;

  /// Set the maximum file size to enable mmap (see [enableMmap] option).
  /// The file size is determined by the sum of all files contained in one download.
  /// For example, if a download contains 5 files, then file size is the total size of those files.
  /// If file size is strictly greater than the size specified in this option, mmap will be disabled.
  /// You can append K or M (1K = 1024, 1M = 1024K).
  ///
  /// Default: `9223372036854775807`
  final String? maxMmapLimit;

  /// When used with [alwaysResume]: `false`, aria2 downloads file from scratch
  /// when aria2 detects [maxResumeFailureTries] number of URIs that does not support resume.
  /// If [maxResumeFailureTries] is `0`, aria2 downloads file from scratch when all given URIs do not support resume.
  /// See [alwaysResume] option.
  ///
  /// Default: `0`
  final int? maxResumeFailureTries;

  /// Set number of tries. `0` means unlimited. See also [retryWait].
  ///
  /// Default: `5`
  final int? maxTries;

  /// Set max upload speed per each torrent in bytes/sec. `0` means unrestricted.
  /// You can append K or M (1K = 1024, 1M = 1024K).
  /// To limit the overall upload speed, use [maxOverallUploadLimit] option.
  ///
  /// Default: `0`
  final String? maxUploadLimit;

  /// Specify base URI to resolve relative URI in metalink:url and
  /// metalink:metaurl element in a metalink file stored in local disk.
  /// If URI points to a directory, URI must end with `/`.
  final String? metalinkBaseUri;

  /// If `true` is given and several protocols are available for a mirror in a metalink file, aria2 uses one of them.
  /// Use [metalinkPreferredProtocol] option to specify the preference of protocol.
  ///
  /// Default: `true`
  final bool? metalinkEnableUniqueProtocol;

  /// The language of the file to download.
  final String? metalinkLanguage;

  /// The location of the preferred server. A comma-delimited list of locations is acceptable, for example, jp,us.
  final List<String>? metalinkLocation;

  /// The operating system of the file to download.
  final String? metalinkOS;

  /// Specify preferred protocol. The possible values are `Aria2MetalinkPreferredProtocol.http`, `Aria2MetalinkPreferredProtocol.https`,
  /// `Aria2MetalinkPreferredProtocol.ftp` and `Aria2MetalinkPreferredProtocol.none`. Specify `Aria2MetalinkPreferredProtocol.none` to disable this feature.
  ///
  /// Default: `Aria2MetalinkPreferredProtocol.none`
  final Aria2MetalinkPreferredProtocol? metalinkPreferredProtocol;

  /// The version of the file to download.
  final String? metalinkVersion;

  /// aria2 does not split less than 2*SIZE byte range. For example, let's consider downloading 20MiB file.
  /// If SIZE is 10M, aria2 can split file into 2 range [0-10MiB) and [10MiB-20MiB) and
  /// download it using 2 sources(if --split >= 2, of course). If SIZE is 15M, since 2*15M > 20MiB,
  /// aria2 does not split file and download it using 1 source. You can append K or M (1K = 1024, 1M = 1024K).
  ///
  /// Possible Values: `1M - 1024M`
  /// Default: `20M`
  final String? minSplitSize;

  /// No file allocation is made for files whose size is smaller than SIZE. You can append K or M (1K = 1024, 1M = 1024K).
  ///
  /// Default: `5M`
  final String? noFileAllocationLimit;

  /// Disables netrc support. netrc support is enabled by default.
  ///
  /// Note:
  /// netrc file is only read at the startup if [noNetrc] is false. So if [noNetrc] is true at the startup,
  /// no netrc is available throughout the session.
  /// You cannot get netrc enabled even if you send [noNetrc]: `false` using `client.changeGlobalOption()`.
  final bool? noNetrc;

  /// Specify a comma separated list of host names, domains and network addresses with or without a subnet mask where no proxy should be used.
  ///
  /// Note:
  /// For network addresses with a subnet mask, both IPv4 and IPv6 addresses work.
  /// The current implementation does not resolve the host name in an URI to compare network addresses specified in [noProxy].
  /// So it is only effective if URI has numeric IP addresses.
  final List<String>? noProxy;

  /// The file name of the downloaded file. It is always relative to the directory given in [dir] option.
  /// When the [forceSequential] option is used, this option is ignored.
  ///
  /// Note:
  /// You cannot specify a file name for Metalink or BitTorrent downloads.
  /// The file name specified here is only used when the URIs fed to aria2 are given on the command line directly,
  /// but not when using [inputFile], [forceSequential] option.
  ///
  /// Example:
  /// aria2c -o myfile.zip "http://mirror1/file.zip" "http://mirror2/file.zip"
  final String? out;

  /// Enable parameterized URI support. You can specify set of parts: http://{sv1,sv2,sv3}/foo.iso.
  /// Also you can specify numeric sequences with step counter: http://host/image[000-100:2].img.
  /// A step counter can be omitted. If all URIs do not point to the same file,
  /// such as the second example above, [forceSequential] option is required.
  ///
  /// Default: `false`
  final bool? parameterizedUri;

  /// Pause download after added. This option is effective only when `--enable-rpc=true` is given in booting.
  ///
  /// Default: `false`
  final bool? pause;

  /// Pause downloads created as a result of metadata download.
  /// There are 3 types of metadata downloads in aria2:
  /// - (1) downloading .torrent file.
  /// - (2) downloading torrent metadata using magnet link.
  /// - (3) downloading metalink file.
  ///
  /// These metadata downloads will generate downloads using their metadata.
  /// This option pauses these subsequent downloads. This option is effective only when `--enable-rpc=true` is given in booting.
  ///
  /// Default: `false`
  final bool? pauseMetadata;

  /// Set a piece length for HTTP/FTP downloads. This is the boundary when aria2 splits a file.
  /// All splits occur at multiple of this length. This option will be ignored in BitTorrent downloads.
  /// It will be also ignored if Metalink file contains piece hashes.
  ///
  /// Note:
  /// The possible use case of [pieceLength] option is change the request range in one HTTP pipelined request.
  /// To enable HTTP pipelining use [enableHttpPipelining].
  ///
  /// Default: `1M`
  final String? pieceLength;

  /// Set the method to use in proxy request. METHOD is either `Aria2ProxyMethod.get` or `Aria2ProxyMethod.tunnel`.
  /// HTTPS downloads always use tunnel regardless of this option.
  ///
  /// Default: `Aria2ProxyMethod.get`
  final Aria2ProxyMethod? proxyMethod;

  /// Validate chunk of data by calculating checksum while downloading a file if chunk checksums are provided.
  ///
  /// Default: `true`
  final bool? realtimeChunkChecksum;

  /// Set an http referrer (Referer). This affects all http/https downloads.
  /// If `*` is given, the download URI is also used as the referrer.
  /// This may be useful when used together with the [parameterizedUri] option.
  final String? referer;

  /// Retrieve timestamp of the remote file from the remote HTTP/FTP server and if it is available, apply it to the local file.
  ///
  /// Default: `false`
  final bool? remoteTime;

  /// Remove control file before download. Using with [allowOverwrite]: `true`,
  /// download always starts from scratch. This will be useful for users behind proxy server which disables resume.
  final bool? removeControlFile;

  /// Set the seconds to wait between retries. When `SEC > 0`, aria2 will retry downloads when the HTTP server returns a 503 response.
  ///
  /// Default: `0`
  final int? retryWait;

  /// Reuse already used URIs if no unused URIs are left.
  ///
  /// Default: `true`
  final bool? reuseUri;

  /// Save the uploaded torrent or metalink metadata in the directory specified by [dir] option.
  /// The file name consists of SHA-1 hash hex string of metadata plus extension.
  /// For torrent, the extension is '.torrent'. For metalink, it is '.meta4'.
  /// If `false` is given to this option, the downloads added by `client.addTorrent()` or `client.addMetalink()` will not be saved by [saveSession] option.
  ///
  /// Default: `true`
  final bool? rpcSaveUploadMetadata;

  /// Specify share ratio. Seed completed torrents until share ratio reaches RATIO.
  /// You are strongly encouraged to specify equals or more than `1.0` here. Specify `0.0` if you intend to do seeding regardless of share ratio.
  /// If [seedTime] option is specified along with this option, seeding ends when at least one of the conditions is satisfied.
  ///
  /// Default: `1.0`
  final double? seedRatio;

  /// Specify seeding time in (fractional) minutes. Also see the [seedRatio] option.
  ///
  /// Note:
  /// Specifying [seedTime]: 0 disables seeding after download completed.
  final double? seedTime;

  /// Set file to download by specifying its index. You can find the file index using the [showFiles] option.
  /// Multiple indexes can be specified by using ,, for example: `3,6`.
  /// You can also use `-` to specify a range: `1-5`. , and `-` can be used together: `1-5,8,9`.
  /// When used with the [-M](https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-M) option,
  /// index may vary depending on the query (see [metalink*] options).
  ///
  /// Note:
  /// In multi file torrent, the adjacent files specified by this option may also be downloaded.
  /// This is by design, not a bug. A single piece may include several files or part of files,
  /// and aria2 writes the piece to the appropriate files.
  final String? selectFile;

  /// Download a file using [split] connections. If more than [split] URIs are given, first [split] URIs are used and remaining URIs are used for backup.
  /// If less than [split] URIs are given, those URIs are used more than once so that [split] connections total are made simultaneously.
  /// The number of connections to the same host is restricted by the [maxConnectionPerServer] option.
  /// See also the [minSplitSize] option.
  ///
  /// Default: `5`
  final int? split;

  /// Set checksum for SSH host public key. TYPE is hash type. The supported hash type is sha-1 or md5.
  /// DIGEST is hex digest. For example: sha-1=b030503d4de4539dc7885e6f0f5e256704edf4c3.
  /// This option can be used to validate server's public key when SFTP is used.
  /// If this option is not set, which is default, no validation takes place.
  final Aria2HashOption? sshHostKeyMd;

  /// Specify piece selection algorithm used in HTTP/FTP download.
  /// A piece is a fixed length segment which is downloaded in parallel in a segmented download.
  ///
  /// Default: `Aria2streamPieceSelector.default`.
  ///
  /// - default
  /// Select a piece to reduce the number of connections established.
  /// This is reasonable default behavior because establishing a connection is an expensive operation.
  /// - inorder
  /// Select a piece closest to the beginning of the file. This is useful for viewing movies while downloading.
  /// [enableHttpPipelining] option may be useful to reduce re-connection overhead.
  /// Note that aria2 honors [minSplitSize] option, so it will be necessary to specify a reasonable value to [minSplitSize] option.
  /// - random
  /// Select a piece randomly. Like inorder, [minSplitSize] option is honored.
  /// - geom
  /// When starting to download a file, select a piece closest to the beginning of the file like inorder,
  /// but then exponentially increases space between pieces. This reduces the number of connections established,
  /// while at the same time downloads the beginning part of the file first. This is useful for viewing movies while downloading.
  final Aria2StreamPieceSelector? streamPieceSelector;

  /// Set timeout in seconds.
  ///
  /// Default: `60`
  final int? timeout;

  /// Specify URI selection algorithm. The possible values are `Aria2UriSelector.inorder`, `Aria2UriSelector.feedback` and `Aria2UriSelector.adaptive`.
  /// If `Aria2UriSelector.inorder` is given, URI is tried in the order appeared in the URI list.
  /// If `Aria2UriSelector.feedback` is given, aria2 uses download speed observed in the previous downloads and choose fastest server in the URI list.
  /// This also effectively skips dead mirrors.
  /// The observed download speed is a part of performance profile of servers mentioned in `--server-stat-of` and `--server-stat-if` options.
  /// If adaptive is given, selects one of the best mirrors for the first and reserved connections.
  /// For supplementary ones, it returns mirrors which has not been tested yet, and if each of them has already been tested,
  /// returns mirrors which has to be tested again. Otherwise, it doesn't select anymore mirrors.
  /// Like `Aria2UriSelector.feedback`, it uses a performance profile of servers.
  ///
  /// Default: `Aria2UriSelector.feedback`
  final Aria2UriSelector? uriSelector;

  /// Use HEAD method for the first request to the HTTP server.
  ///
  /// Default: `false`
  final bool? useHead;

  /// Set user agent for HTTP(S) downloads.
  ///
  /// Default: `aria2/$VERSION`, `$VERSION` is replaced by package version.
  final String? userAgent;

  const Aria2InputFileOption({
    this.allProxy,
    this.allProxyPasswd,
    this.allProxyUser,
    this.allowOverwrite,
    this.allowPieceLengthChange,
    this.alwaysResume,
    this.asyncDns,
    this.autoFileRenaming,
    this.btEnableHookAfterHashCheck,
    this.btEnableLpd,
    this.btExcludeTracker,
    this.btExternalIP,
    this.btForceEncryption,
    this.btHashCheckSeed,
    this.btLoadSavedMetadata,
    this.btMaxPeers,
    this.btMetadataOnly,
    this.btMinCryptoLevel,
    this.btPrioritizePiece,
    this.btRemoveUnselectedFile,
    this.btRequestPeerSpeedLimit,
    this.btRequireCrypto,
    this.btSaveMetadata,
    this.btSeedUnverified,
    this.btStopTimeout,
    this.btTracker,
    this.btTrackerConnectTimeout,
    this.btTrackerInterval,
    this.btTrackerTimeout,
    this.checkIntegrity,
    this.checksum,
    this.conditionalGet,
    this.connectTimeout,
    this.contentDispositionDefaultUtf8,
    this.aria2Continue,
    this.dir,
    this.dryRun,
    this.enableHttpKeepAlive,
    this.enableHttpPipelining,
    this.enableMmap,
    this.enablePeerExchange,
    this.fileAllocation,
    this.followMetalink,
    this.followTorrent,
    this.forceSave,
    this.ftpPasswd,
    this.ftpPasv,
    this.ftpProxy,
    this.ftpProxyPasswd,
    this.ftpProxyUser,
    this.ftpReuseConnection,
    this.ftpType,
    this.ftpUser,
    this.gid,
    this.hashCheckOnly,
    this.header,
    this.httpAcceptGzip,
    this.httpAuthChallenge,
    this.httpNoCache,
    this.httpPasswd,
    this.httpProxy,
    this.httpProxyPasswd,
    this.httpProxyUser,
    this.httpUser,
    this.httpsProxy,
    this.httpsProxyPasswd,
    this.httpsProxyUser,
    this.indexOut,
    this.lowestSpeedLimit,
    this.maxConnectionPerServer,
    this.maxDownloadLimit,
    this.maxFileNotFound,
    this.maxMmapLimit,
    this.maxResumeFailureTries,
    this.maxTries,
    this.maxUploadLimit,
    this.metalinkBaseUri,
    this.metalinkEnableUniqueProtocol,
    this.metalinkLanguage,
    this.metalinkLocation,
    this.metalinkOS,
    this.metalinkPreferredProtocol,
    this.metalinkVersion,
    this.minSplitSize,
    this.noFileAllocationLimit,
    this.noNetrc,
    this.noProxy,
    this.out,
    this.parameterizedUri,
    this.pause,
    this.pauseMetadata,
    this.pieceLength,
    this.proxyMethod,
    this.realtimeChunkChecksum,
    this.referer,
    this.remoteTime,
    this.removeControlFile,
    this.retryWait,
    this.reuseUri,
    this.rpcSaveUploadMetadata,
    this.seedRatio,
    this.seedTime,
    this.selectFile,
    this.split,
    this.sshHostKeyMd,
    this.streamPieceSelector,
    this.timeout,
    this.uriSelector,
    this.useHead,
    this.userAgent,
  });

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

    return result;
  }

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll(
            parametrized.entries.map((e) => '${e.key}: ${e.value}'),
            ', ',
          )
          ..write(')'))
        .toString();
  }
}

class Aria2LinkedServerInfo {
  final String uri;
  final String currentUri;
  final int downloadSpeed;

  const Aria2LinkedServerInfo({
    required this.uri,
    required this.currentUri,
    required this.downloadSpeed,
  });

  Aria2LinkedServerInfo.fromMap(Map<String, dynamic> map)
    : this(
        uri: map['uri'],
        currentUri: map['currentUri'],
        downloadSpeed: int.parse(map['downloadSpeed']),
      );
}

class Aria2Method {
  final Aria2MethodName methodName;
  final Aria2ParameterBuilder params;

  const Aria2Method(this.methodName, this.params);

  @override
  String toString() {
    return 'Aria2Method(methodName: ${methodName.alias}, params: $params)';
  }
}

abstract class Aria2ParameterBuilder {
  const Aria2ParameterBuilder();

  factory Aria2ParameterBuilder.empty() => const _Aria2EmptyParameterBuilder();

  factory Aria2ParameterBuilder.multicall(List<Aria2Method> parameterList) =>
      _Aria2MultiCallParameterBuilder(parameterList);

  factory Aria2ParameterBuilder.normal(List<dynamic> parameterList) =>
      _Aria2NormalParameterBuilder(parameterList);

  List<dynamic> get value;

  List<dynamic> buildParamList([String? secret]);

  @override
  String toString() {
    return value.toString();
  }
}

class _Aria2EmptyParameterBuilder extends Aria2ParameterBuilder {
  const _Aria2EmptyParameterBuilder();

  @override
  List<dynamic> get value => const [];

  @override
  List<dynamic> buildParamList([String? secret]) {
    return [if (secret != null) 'token:$secret'];
  }
}

class _Aria2MultiCallParameterBuilder extends Aria2ParameterBuilder {
  final List<Aria2Method> _value;

  const _Aria2MultiCallParameterBuilder(this._value);

  @override
  List<Aria2Method> get value => _value;

  @override
  List<dynamic> buildParamList([String? secret]) {
    final result = <Map<String, dynamic>>[];
    for (final i in _value) {
      final params = i.methodName.noRequireSecret
          ? i.params.buildParamList()
          : i.params.buildParamList(secret);
      result.add({'methodName': i.methodName.alias, 'params': params});
    }

    return [result];
  }
}

class _Aria2NormalParameterBuilder extends Aria2ParameterBuilder {
  final List<dynamic> _value;

  const _Aria2NormalParameterBuilder(this._value);

  @override
  List<dynamic> get value => _value;

  @override
  List<dynamic> buildParamList([String? secret]) {
    return [if (secret != null) 'token:$secret', ..._value];
  }
}

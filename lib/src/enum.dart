import 'package:aria2_api/src/_internal.dart';
import 'package:aria2_api/src/error.dart';
import 'package:aria2_api/src/result.dart';
import 'package:aria2_api/src/struct.dart';

enum Aria2BitTorrentMode { single, multi }

enum Aria2BtCryptoLevel { plain, arc4 }

enum Aria2DownloadingStatus {
  active,
  waiting,
  paused,
  error,
  complete,
  removed,
}

enum Aria2DownloadResult with AliasEnumMixin {
  defaults('default'),
  full('full'),
  hide('hide');

  final String _alias;

  const Aria2DownloadResult(this._alias);

  @override
  String get alias => _alias;
}

enum Aria2FileAllocationMethod { none, prealloc, trunc, falloc }

enum Aria2FTPType { ascii, binary }

enum Aria2HashType with AliasEnumMixin {
  sha1('sha-1'),
  sha224('sha-224'),
  sha256('sha-256'),
  sha384('sha-384'),
  sha512('sha-512'),
  md5('md5'),
  adler32('adler32');

  final String _label;

  const Aria2HashType(this._label);

  @override
  String get alias => _label;
}

enum Aria2HttpFunction { get, post }

enum Aria2LogLevel { debug, info, notice, warn, error }

enum Aria2MetalinkPreferredProtocol { http, https, ftp, none }

enum Aria2MethodName with AliasEnumMixin {
  /// {@template aria2_api.add_uri}
  /// This method adds a new download.
  ///
  /// `uris` is an array of HTTP/FTP/SFTP/BitTorrent URIs pointing to the same resource.
  /// If you mix URIs pointing to different resources, then the download may fail or be corrupted without aria2 complaining.
  /// When adding BitTorrent Magnet URIs, uris must have only one element and it should be BitTorrent Magnet URI.
  ///
  /// `option` is a struct and its members are pairs of option name and value. See [Aria2InputFileOption] below for more details.
  ///
  /// If `position` is given, it must be an integer starting from `0`.
  /// The new download will be inserted at position in the waiting queue.
  /// If position is omitted or position is larger than the current size of the queue,
  /// the new download is appended to the end of the queue.
  ///
  /// This method returns the [Aria2StringResult] with GID of the newly registered download.
  /// {@endtemplate}
  addUri('aria2'),

  /// {@template aria2_api.add_torrent}
  /// This method adds a BitTorrent download by uploading a ".torrent" file.
  /// If you want to add a BitTorrent Magnet URI, use the [addUri] method instead.
  ///
  /// `torrent` must be a base64-encoded string containing the contents of the ".torrent" file.
  ///
  /// `uris` is an array of URIs. uris is used for Web-seeding. For single file torrents,
  /// the URI can be a complete URI pointing to the resource; if URI ends with `/`,
  /// name in torrent file is added. For multi-file torrents,
  /// name and path in torrent are added to form a URI for each file.
  ///
  /// `option` is a struct and its members are pairs of option name and value. See [Aria2InputFileOption] below for more details.
  ///
  /// If `position` is given, it must be an integer starting from `0`.
  /// The new download will be inserted at position in the waiting queue.
  /// If `position` is omitted or position is larger than the current size of the queue,
  /// the new download is appended to the end of the queue.
  ///
  /// This method returns the [Aria2StringResult] with GID of the newly registered download.
  ///
  /// If [Aria2InputFileOption.rpcSaveUploadMetadata] is `true`,
  /// the uploaded data is saved as a file named as the hex string of SHA-1 hash of data plus ".torrent" in the directory specified by [Aria2InputFileOption.dir] option.
  /// E.g., a file name might be 0a3893293e27ac0490424c06de4d09242215f0a6.torrent.
  /// If a file with the same name already exists,
  /// it is overwritten! If the file cannot be saved successfully or [Aria2InputFileOption.rpcSaveUploadMetadata] is `false`,
  /// the downloads added by this method are not saved by [Aria2OptionObject.saveSession].
  /// {@endtemplate}
  addTorrent('aria2'),

  /// {@template aria2_api.add_metalink}
  /// This method adds a Metalink download by uploading a ".metalink" file.
  ///
  /// `metalink` is a base64-encoded string which contains the contents of the ".metalink" file.
  ///
  /// `option` is a struct and its members are pairs of option name and value. See [Aria2InputFileOption] below for more details.
  ///
  /// If `position` is given, it must be an integer starting from 0.
  /// The new download will be inserted at position in the waiting queue.
  /// If `position` is omitted or position is larger than the current size of the queue,
  /// the new download is appended to the end of the queue.
  ///
  /// This method returns a [List] of GIDs of newly registered downloads.
  ///
  /// If [Aria2InputFileOption.rpcSaveUploadMetadata] is `true`, the uploaded data is saved
  /// as a file named hex string of SHA-1 hash of data plus ".metalink" in the directory specified by [Aria2InputFileOption.dir] option.
  ///
  /// E.g., a file name might be 0a3893293e27ac0490424c06de4d09242215f0a6.metalink.
  /// If a file with the same name already exists, it is overwritten!
  /// If the file cannot be saved successfully or [Aria2InputFileOption.rpcSaveUploadMetadata] is `false`,
  /// the downloads added by this method are not saved by [Aria2OptionObject.saveSession].
  /// {@endtemplate}
  addMetalink('aria2'),

  /// {@template aria2_api.remove}
  /// This method removes the download denoted by `gid`. If the specified download is in progress, it is first stopped.
  /// The status of the removed download becomes removed. This method returns [Aria2StringResult] with GID of removed download.
  /// {@endtemplate}
  remove('aria2'),

  /// {@template aria2_api.force_remove}
  /// This method removes the download denoted by `gid`.
  /// This method behaves just like [remove] except that this method removes the download without
  /// performing any actions which take time, such as contacting BitTorrent trackers to unregister the download first.
  /// {@endtemplate}
  forceRemove('aria2'),

  /// {@template aria2_api.pause}
  /// This method pauses the download denoted by `gid`. The status of paused download becomes paused.
  /// If the download was active, the download is placed in the front of waiting queue.
  /// While the status is paused, the download is not started. To change status to waiting,
  /// use the [unpause] method. This method returns [Aria2StringResult] with GID of paused download.
  /// {@endtemplate}
  pause('aria2'),

  /// {@template aria2_api.pause_all}
  /// This method is equal to calling [pause] for every active/waiting download. This methods returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  pauseAll('aria2'),

  /// {@template aria2_api.force_pause}
  /// This method pauses the download denoted by `gid`.
  /// This method behaves just like [pause] except that this method pauses downloads without
  /// performing any actions which take time, such as contacting BitTorrent trackers to unregister the download first.
  /// {@endtemplate}
  forcePause('aria2'),

  /// {@template aria2_api.force_pause_all}
  /// This method is equal to calling [forcePause] for every active/waiting download. This methods returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  forcePauseAll('aria2'),

  /// {@template aria2_api.unpause}
  /// This method changes the status of the download denoted by `gid` from paused to waiting,
  /// making the download eligible to be restarted. This method returns [Aria2StringResult] with GID of the unpaused download.
  /// {@endtemplate}
  unpause('aria2'),

  /// {@template aria2_api.unpause_all}
  /// This method is equal to calling [unpause] for every paused download. This methods returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  unpauseAll('aria2'),

  /// {@template aria2_api.tell_status}
  /// This method returns the progress of the download denoted by `gid`.
  ///
  /// `keys` is an array of strings (use [Aria2DownloadingStatusObject.buildKeys] to create keys).
  /// If specified, the response contains only keys in the keys array.
  /// If `keys` is empty or omitted, the response contains all keys.
  /// This is useful when you just want specific keys and avoid unnecessary transfers.
  ///
  /// For example, aria2.tellStatus("2089b05ecca3d829", ["gid", "status"]) returns the gid and status keys only.
  ///
  /// The response is a [Aria2DownloadingStatusObject] and contains following keys.
  /// {@endtemplate}
  tellStatus('aria2'),

  /// {@template aria2_api.get_uris}
  /// This method returns the URIs used in the download denoted by `gid`.
  /// The response is a [List] of [Aria2DownloadingUriObject].
  /// {@endtemplate}
  getUris('aria2'),

  /// {@template aria2_api.get_files}
  /// This method returns the file list of the download denoted by `gid`.
  /// The response is a [List] of [Aria2DownloadingFileObject].
  /// {@endtemplate}
  getFiles('aria2'),

  /// {@template aria2_api.get_peers}
  /// This method returns a list peers of the download denoted by `gid`.
  /// This method is for BitTorrent only. The response is a [List] of [Aria2DownloadingPeerObject].
  /// {@endtemplate}
  getPeers('aria2'),

  /// {@template aria2_api.get_servers}
  /// This method returns currently connected HTTP(S)/FTP/SFTP servers of the download denoted by `gid`.
  /// The response is a [List] of [Aria2LinkedServerObject].
  /// {@endtemplate}
  getServers('aria2'),

  /// {@template aria2_api.tell_active}
  /// This method returns a list of active downloads.
  /// The response is a [List] with same [Aria2DownloadingStatusObject]s as returned by the [tellStatus] method.
  ///
  /// For the `keys` parameter, please refer to the [tellStatus] method.
  /// {@endtemplate}
  tellActive('aria2'),

  /// {@template aria2_api.tell_waiting}
  /// This method returns a list of waiting downloads, including paused ones.
  ///
  /// `offset` is an integer and specifies the offset from the download waiting at the front.
  ///
  /// `number` is an integer and specifies the max. number of downloads to be returned.
  ///
  /// For the `keys` parameter, please refer to the [tellStatus] method.
  ///
  /// If `offset` is a positive integer, this method returns downloads in the range of [offset, offset + number).
  /// `offset` can be a negative integer. `offset == -1` points last download
  /// in the waiting queue and `offset == -2` points the download before the last download, and so on.
  /// Downloads in the response are in reversed order then.
  ///
  /// For example, imagine three downloads "A","B" and "C" are waiting in this order.
  /// aria2.tellWaiting(0, 1) returns ["A"]. aria2.tellWaiting(1, 2) returns ["B", "C"].
  /// aria2.tellWaiting(-1, 2) returns ["C", "B"].
  ///
  /// The response is a [List] with same [Aria2DownloadingStatusObject]s as returned by [tellStatus] method.
  /// {@endtemplate}
  tellWaiting('aria2'),

  /// {@template aria2_api.tell_stopped}
  /// This method returns a list of stopped downloads.
  ///
  /// `offset` is an integer and specifies the offset from the least recently stopped download.
  ///
  /// `number` is an integer and specifies the max. number of downloads to be returned.
  ///
  /// For the `keys` parameter, please refer to the [tellStatus] method.
  ///
  /// `offset` and `number` have the same semantics as described in the [tellWaiting] method.
  ///
  /// The response is a [List] with same [Aria2DownloadingStatusObject] as returned by [tellStatus] method.
  /// {@endtemplate}
  tellStopped('aria2'),

  /// {@template aria2_api.change_position}
  /// This method changes the position of the download denoted by `gid` in the queue.
  /// `pos` is an integer. `how` is a string.
  /// If `how` is [Aria2PositionSymbol.posSet], it moves the download to a position relative to the beginning of the queue.
  /// If `how` is [Aria2PositionSymbol.posCur], it moves the download to a position relative to the current position.
  /// If `how` is [Aria2PositionSymbol.posEnd], it moves the download to a position relative to the end of the queue.
  /// If the destination position is less than 0 or beyond the end of the queue,
  /// it moves the download to the beginning or the end of the queue respectively.
  ///
  /// The response is a [Aria2IntegerResult] denoting the resulting position.
  ///
  /// For example, if GID#2089b05ecca3d829 is currently in position 3,
  /// aria2.changePosition('2089b05ecca3d829', -1, 'POS_CUR') will change its position to 2.
  /// Additionally aria2.changePosition('2089b05ecca3d829', 0, Aria2PositionSymbol.posSet) will change its position to 0 (the beginning of the queue).
  /// {@endtemplate}
  changePosition('aria2'),

  /// {@template aria2_api.change_uri}
  /// This method removes the URIs in `delUris` from and appends the URIs in `addUris` to download denoted by `gid`.
  /// `delUris` and `addUris` are lists of strings. A download can contain multiple files and URIs are attached to each file.
  /// `fileIndex` is used to select which file to remove/attach given URIs.
  /// `fileIndex` is 1-based. position is used to specify where URIs are inserted in the existing waiting URI list.
  /// `position` is 0-based. When position is omitted, URIs are appended to the back of the list.
  ///
  /// This method first executes the removal and then the addition. `position` is the position after URIs are removed,
  /// not the position when this method is called. When removing an URI, if the same URIs exist in download,
  /// only one of them is removed for each URI in delUris.
  /// In other words, if there are three URIs http://example.org/aria2 and you want remove them all,
  /// you have to specify (at least) 3 http://example.org/aria2 in delUris.
  /// This method returns a [List] which contains two [Aria2IntegerResult].
  /// The first [Aria2IntegerResult] is the number of URIs deleted. The second [Aria2IntegerResult] is the number of URIs added.
  /// {@endtemplate}
  changeUri('aria2'),

  /// {@template aria2_api.get_option}
  /// This method returns option of the download denoted by `gid`.
  /// The response is a [Aria2OptionObject] where keys are the names of option.
  ///
  /// Note that this method does not return option which have no default value and have not been set on the command-line,
  /// in configuration files or RPC methods.
  /// {@endtemplate}
  getOption('aria2'),

  /// {@template aria2_api.change_option}
  /// This method changes option of the download denoted by `gid` dynamically.
  /// `option` is a [Aria2OptionObject]. The option listed in Input File subsection are available,
  /// except for following option:
  /// - [Aria2OptionObject.dryRun]
  /// - [Aria2OptionObject.metalinkBaseUri]
  /// - [Aria2OptionObject.parameterizedUri]
  /// - [Aria2OptionObject.pause]
  /// - [Aria2OptionObject.pieceLength]
  /// - [Aria2OptionObject.rpcSaveUploadMetadata]
  ///
  /// Except for the following option, changing the other option of active download makes it restart
  /// (restart itself is managed by aria2, and no user intervention is required):
  /// - [Aria2OptionObject.btMaxPeers]
  /// - [Aria2OptionObject.btRequestPeerSpeedLimit]
  /// - [Aria2OptionObject.btRemoveUnselectedFile]
  /// - [Aria2OptionObject.forceSave]
  /// - [Aria2OptionObject.maxDownloadLimit]
  /// - [Aria2OptionObject.maxUploadLimit]
  ///
  /// This method returns [Aria2StringResult] with OK for success.
  /// {@endtemplate}
  changeOption('aria2'),

  /// {@template aria2_api.get_global_option}
  /// This method returns the global option. The response is a [Aria2OptionObject].
  /// Its keys are the names of option.
  ///
  /// Note that this method does not return option which have no default value and have not been set on the command-line,
  /// in configuration files or RPC methods. Because global option are used as a template for the option of newly added downloads,
  /// the response contains keys returned by the [getOption] method.
  /// {@endtemplate}
  getGlobalOption('aria2'),

  /// {@template aria2_api.change_global_option}
  /// This method changes global option dynamically. `option` is a [Aria2OptionObject.global]. The following option are available:
  /// - [Aria2OptionObject.btMaxOpenFiles]
  /// - [Aria2OptionObject.downloadResult]
  /// - [Aria2OptionObject.keepUnfinishedDownloadResult]
  /// - [Aria2OptionObject.log]
  /// - [Aria2OptionObject.logLevel]
  /// - [Aria2OptionObject.maxConcurrentDownloads]
  /// - [Aria2OptionObject.maxDownloadResult]
  /// - [Aria2OptionObject.maxOverallDownloadLimit]
  /// - [Aria2OptionObject.maxOverallUploadLimit]
  /// - [Aria2OptionObject.optimizeConcurrentDownloads]
  /// - [Aria2OptionObject.saveCookies]
  /// - [Aria2OptionObject.saveSession]
  /// - [Aria2OptionObject.serverStatOf]
  ///
  /// In addition, option listed in the Input File subsection are available,
  /// except for following option:
  /// - [Aria2OptionObject.checksum]
  /// - [Aria2OptionObject.indexOut]
  /// - [Aria2OptionObject.out]
  /// - [Aria2OptionObject.pause]
  /// - [Aria2OptionObject.selectFile]
  ///
  /// With the [Aria2OptionObject.log] option, you can dynamically start logging or change log file.
  /// To stop logging, specify an empty string as the parameter value.
  /// Note that log file is always opened in append mode.
  ///
  /// This method returns [Aria2StringResult] with OK for success.
  /// {@endtemplate}
  changeGlobalOption('aria2'),

  /// {@template aria2_api.get_global_stat}
  /// This method returns global statistics such as the overall download and upload speeds.
  /// The response is a [Aria2GlobalStatObject].
  /// {@endtemplate}
  getGlobalStat('aria2'),

  /// {@template aria2_api.purge_download_result}
  /// This method purges completed/error/removed downloads to free memory. This method returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  purgeDownloadResult('aria2'),

  /// {@template aria2_api.remove_download_result}
  /// This method removes a completed/error/removed download denoted by `gid` from memory. This method returns [Aria2StringResult] with OK for success.
  /// {@endtemplate}
  removeDownloadResult('aria2'),

  /// {@template aria2_api.get_version}
  /// This method returns the version of aria2 and the list of enabled features. The response is a [Aria2VersionObject].
  /// {@endtemplate}
  getVersion('aria2'),

  /// {@template aria2_api.get_session_info}
  /// This method returns session information. The response is a [Aria2SessionInfoObject].
  /// {@endtemplate}
  getSessionInfo('aria2'),

  /// {@template aria2_api.shutdown}
  /// This method shuts down aria2. This method returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  shutdown('aria2'),

  /// {@template aria2_api.force_shutdown}
  /// This method shuts down aria2. This method behaves like [shutdown] without performing any actions which take time,
  /// such as contacting BitTorrent trackers to unregister downloads first. This method returns [Aria2StringResult] with OK.
  /// {@endtemplate}
  forceShutdown('aria2'),

  /// {@template aria2_api.save_session}
  /// This method saves the current session to a file specified by the [Aria2OptionObject.saveSession] option. This method returns [Aria2StringResult] with OK if it succeeds.
  /// {@endtemplate}
  saveSession('aria2'),

  /// {@template aria2_api.multicall}
  /// This methods encapsulates multiple method calls in a single request. `methods` is a [List] of [Aria2Method].
  /// [Aria2Method] contain two keys: `methodName` and `params`.
  /// methodName is the method name to call and params is array containing parameters to the method call.
  /// This method returns a [List] of responses.
  /// The elements will be either a one-item [List] containing the return value of the method call or a [Aria2Error] of fault element if an encapsulated method call fails.
  /// {@endtemplate}
  multicall('system'),

  /// {@template aria2_api.list_methods}
  /// This method returns all the available RPC methods in a [List] of [Aria2StringResult].
  /// Unlike other methods, this method does not require secret token.
  /// This is safe because this method just returns the available method names.
  /// {@endtemplate}
  /// {@tool snippet}
  ///
  /// Example:
  ///
  /// ```dart
  /// Aria2Method(Aria2MethodType.listMethods, Aria2ParameterBuilder.empty())
  /// ```
  /// {@end-tool}
  listMethods('system'),

  /// {@template aria2_api.list_notifications}
  /// This method returns all the available RPC notifications in a [List] of [Aria2StringResult].
  /// Unlike other methods, this method does not require secret token.
  /// This is safe because this method just returns the available notifications names.
  /// {@endtemplate}
  /// {@tool snippet}
  ///
  /// Example:
  ///
  /// ```dart
  /// Aria2Method(
  ///   Aria2MethodType.listNotifications,
  ///   Aria2ParameterBuilder.empty(),
  /// )
  /// ```
  /// {@end-tool}
  listNotifications('system');

  final String prefix;

  const Aria2MethodName(this.prefix);

  @override
  String get alias => '$prefix.$name';

  bool get noRequireSecret => this == listMethods || this == listNotifications;
}

enum Aria2NotificationName with AliasEnumMixin {
  onDownloadStart,
  onDownloadPause,
  onDownloadStop,
  onDownloadComplete,
  onDownloadError,
  onBtDownloadComplete;

  @override
  String get alias => 'aria2.$name';
}

enum Aria2PositionSymbol with AliasEnumMixin {
  posSet('POS_SET'),
  posCur('POS_CUR'),
  posEnd('POS_END');

  final String _alias;

  const Aria2PositionSymbol(this._alias);

  @override
  String get alias => _alias;
}

enum Aria2ProxyMethod { get, tunnel }

enum Aria2StreamPieceSelector with AliasEnumMixin {
  defaults('default'),
  inorder('inorder'),
  random('random'),
  geom('geom');

  final String _alias;

  const Aria2StreamPieceSelector(this._alias);

  @override
  String get alias => _alias;
}

enum Aria2Symbol with AliasEnumMixin {
  yes('true'),
  no('false'),
  mem('mem');

  final String _alias;

  const Aria2Symbol(this._alias);

  @override
  String get alias => _alias;
}

enum Aria2UriSelector { inorder, feedback, adaptive }

enum Aria2UriStatus { used, waiting }

// This file is part of GNOME Games. License: GPLv3

private class Games.NesPlugin : Object, Plugin {
	private const string NES_FINGERPRINT_PREFIX = "nes";
	private const string NES_MIME_TYPE = "application/x-nes-rom";

	private const string FDS_FINGERPRINT_PREFIX = "fds";
	private const string FDS_MIME_TYPE = "application/x-fds-disk";

	private const string MODULE_BASENAME = "libretro-nes.so";
	private const bool SUPPORTS_SNAPSHOTTING = true;

	public GameSource get_game_source () throws Error {
		var nes_game_uri_adapter = new GenericSyncGameUriAdapter (nes_game_for_uri);
		var fds_game_uri_adapter = new GenericSyncGameUriAdapter (fds_game_for_uri);
		var nes_factory = new GenericUriGameFactory (nes_game_uri_adapter);
		var fds_factory = new GenericUriGameFactory (fds_game_uri_adapter);
		var nes_query = new MimeTypeTrackerQuery (NES_MIME_TYPE, nes_factory);
		var fds_query = new MimeTypeTrackerQuery (FDS_MIME_TYPE, fds_factory);
		var connection = Tracker.Sparql.Connection.@get ();
		var source = new TrackerGameSource (connection);
		source.add_query (nes_query);
		source.add_query (fds_query);

		return source;
	}

	private static Game nes_game_for_uri (string uri) throws Error {
		var uid = new FingerprintUid (uri, NES_FINGERPRINT_PREFIX);
		var title = new FilenameTitle (uri);
		var icon = new DummyIcon ();
		var media = new GriloMedia (title, NES_MIME_TYPE);
		var cover = new CompositeCover ({
			new LocalCover (uri),
			new GriloCover (media, uid)});
		var runner = new RetroRunner (uri, uid, { NES_MIME_TYPE }, MODULE_BASENAME, SUPPORTS_SNAPSHOTTING);

		return new GenericGame (title, icon, cover, runner);
	}

	private static Game fds_game_for_uri (string uri) throws Error {
		var uid = new FingerprintUid (uri, FDS_FINGERPRINT_PREFIX);
		var title = new FilenameTitle (uri);
		var icon = new DummyIcon ();
		var media = new GriloMedia (title, FDS_MIME_TYPE);
		var cover = new CompositeCover ({
			new LocalCover (uri),
			new GriloCover (media, uid)});
		var runner = new RetroRunner (uri, uid, { FDS_MIME_TYPE }, MODULE_BASENAME, SUPPORTS_SNAPSHOTTING);

		return new GenericGame (title, icon, cover, runner);
	}
}

[ModuleInit]
public Type register_games_plugin (TypeModule module) {
	return typeof(Games.NesPlugin);
}

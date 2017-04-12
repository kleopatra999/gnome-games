// This file is part of GNOME Games. License: GPL-3.0+.

private class Games.GameCubePlugin : Object, Plugin {
	private const string MIME_TYPE = "application/x-gamecube-rom";
	private const string PLATFORM = "GameCube";

	public GameSource get_game_source () throws Error {
		var game_uri_adapter = new GenericSyncGameUriAdapter (game_for_uri);
		var uri_test = new GenericMimeTypeUriTest (MIME_TYPE);
		var factory = new GenericUriGameFactory (game_uri_adapter, uri_test);
		var query = new MimeTypeTrackerQuery (MIME_TYPE, factory);
		var connection = Tracker.Sparql.Connection.@get ();
		var source = new TrackerGameSource (connection);
		source.add_query (query);

		return source;
	}

	private static Game game_for_uri (string uri) throws Error {
		var file = File.new_for_uri (uri);
		var header = new GameCubeHeader (file);
		header.check_validity ();

		var uid = new GameCubeUid (header);
		var title = new FilenameTitle (uri);
		var icon = new DummyIcon ();
		var media = new GriloMedia (title, MIME_TYPE);
		var cover = new CompositeCover ({
			new LocalCover (uri),
			new GriloCover (media, uid)});
		var core_source = new RetroCoreSource (PLATFORM, { MIME_TYPE });
		var runner = new RetroRunner (core_source, uri, uid, title);

		return new GenericGame (title, icon, cover, runner);
	}
}

[ModuleInit]
public Type register_games_plugin (TypeModule module) {
	return typeof(Games.GameCubePlugin);
}

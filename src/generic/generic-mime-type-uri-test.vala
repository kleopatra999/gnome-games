// This file is part of GNOME Games. License: GPL-3.0+.

public class Games.GenericMimeTypeUriTest : UriTest, Object {
	public delegate Game GameForUri (string uri) throws Error;

	private string mime_type;

	public GenericMimeTypeUriTest (string mime_type) {
		this.mime_type = mime_type;
	}

	public bool is_uri_valid (string uri) {
		var file = File.new_for_uri (uri);
		try {
			var info = file.query_info ("standard::content-type", FileQueryInfoFlags.NONE);
			var actual_type = info.get_content_type ();

			return ContentType.is_a (actual_type, mime_type);
		}
		catch (Error e) {
			debug (e.message);

			return false;
		}
	}
}

// This file is part of GNOME Games. License: GPL-3.0+.

public interface Games.GameUriAdapter : Object {
	public abstract Game game_for_uri (string uri) throws Error;
	public abstract async Game game_for_uri_async (string uri) throws Error;
}

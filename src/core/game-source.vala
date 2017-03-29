// This file is part of GNOME Games. License: GPL-3.0+.

public interface Games.GameSource : Object {
	public abstract Game game_for_uri (string uri) throws Error;
	public abstract async void each_game (GameCallback callback);
}

public delegate void Games.GameCallback (Game game);

public interface Games.UriGameFactory : Object {
	public abstract bool is_uri_valid (string uri);
	public abstract void add_uri (string uri);
	public abstract Game game_for_uri (string uri) throws Error;
	public abstract async void foreach_game (Games.GameCallback game_callback);
}

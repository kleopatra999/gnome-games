plugindir = $(libdir)/gnome-games/plugins
plugin_LTLIBRARIES = libgames-snes-plugin.la

libgames_snes_plugin_la_DEPENDENCIES = \
	$(top_builddir)/src/gnome-games.vapi \
	$(NULL)

libgames_snes_plugin_la_SOURCES = \
	snes-plugin.vala \
	$(NULL)

libgames_snes_plugin_la_VALAFLAGS = \
	--target-glib=@GLIB_MIN_VERSION@ \
	--pkg gnome-games \
	--vapidir $(top_builddir)/src \
	$(NULL)

libgames_snes_plugin_la_CFLAGS = \
	$(SNES_PLUGIN_CFLAGS) \
	$(GNOME_GAMES_CFLAGS) \
	-DG_LOG_DOMAIN=\"GamesDesktop\" \
	-DLOCALEDIR=\"$(localedir)\" \
	$(NULL)

libgames_snes_plugin_la_CPPFLAGS = \
	-I$(top_srcdir) \
	-I$(top_srcdir)/src \
	$(NULL)

libgames_snes_plugin_la_LIBADD = \
	$(SNES_PLUGIN_LIBS) \
	$(GNOME_GAMES_LIBS) \
	$(NULL)

libgames_snes_plugin_la_LDFLAGS = \
	-no-undefined \
	-module \
	-avoid-version \
	$(NULL)

EXTRA_DIST = \
	$(plugin_DATA) \
	$(NULL)

MAINTAINERCLEANFILES = \
	$(BUILT_SOURCES) \
	$(NULL)

-include $(top_srcdir)/git.mk

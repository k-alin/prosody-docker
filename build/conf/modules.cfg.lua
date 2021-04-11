-- This is the list of modules Prosody will load on startup.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands.
		"blocklist"; -- Support privacy lists.
		"blocking"; -- Allow users to block communications with other users.
		"bookmarks"; -- Allow users to manage bookmarks to communications.
		"bosh"; -- Enable BOSH ("XMPP over HTTP") for web clients .
		"carbons"; -- Syncing of messages between compatible devices.
		"cloud_notify"; -- "Push notifcations" for new messages.
		"csi"; -- Client state indication for less data transfer.
		"csi_battery_saver"; -- Hold unimportant stanzas until client comes online. 
		"dialback"; -- s2s dialback support.
		"disco"; -- Service discovery.
		"http_upload_external"; -- Upload files to a server and share with others.
		"invite"; -- Allows users to invite new users.
		"lastlog"; -- Store time stamp of user's last login.
		"log_auth"; -- Log failed login attempts.
		"mam"; -- Store chat history server sided.
		"offline"; -- Store offline messages.
		"pep"; -- Publish details about mood, music one is listening to or the current activity.
		"ping"; -- Replies to XMPP pings with pongs.
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"proxy65";
		"register"; -- Allow users to register on this server using a client and change passwords.
		"register_web"; -- Allow users to register online.
		"roster"; -- Allow users to have a roster.
		"saslauth"; -- Authentication for clients and servers.
		"server_contact_info"; -- Publish admin and contact information about the server.
		"smacks"; -- Support for unstable (mobile) Networks.
		"time"; -- Let others know the time here on this server.
		"turncredentials"; -- Turn server for audio and video calls
		"tls"; -- Add support for secure TLS on connections.
		"throttle_presence"; -- Reduce presence status updates.
		"uptime"; -- Report how long server has been running.
		"vcard_legacy"; -- Convert vcards between legacy formats.
		"version"; -- Replies to server version requests.
		"watchregistrations"; -- Alert admins of registrations.
		-- "admin_telnet"; -- Opens telnet console interface on localhost port 5582.
		-- "announce"; -- Send announcement to all online users.
		-- "groups"; -- Shared roster support.
		-- "http_files"; -- Serve static files from a directory over HTTP.
		-- "motd"; -- Send a message to users when they log in.
		-- "websocket"; -- Websockets are cool, but probably not ready, yet.
		--"welcome"; -- Welcome users who register accounts.
}

-- Set up a MUC (multi-user chat) room server:
Component ("{{XMPP_GROUPS_URL}}") "muc"

    name = "Groups"
    muc_log_by_default = false; -- Enable logging by default (can be disabled in room config)
    muc_log_all_rooms = false; -- set to true to force logging of all rooms
    max_history_messages = "{{MAX_HISTORY}}"; 
    restrict_room_creation = false
    modules_enabled = { 
            "muc_mam"; -- Store mucs' chat history server sided.
            "vcard_muc"; -- Avatars for group chats
    }
    ssl = {
            key = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.key";
            certificate = "/etc/prosody/certs/{{XMPP_GROUPS_URL}}.crt";
    }

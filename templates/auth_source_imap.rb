##
# Redmine IMAP Authentication Module
#
# All rights avoided, you are free to distribute or modify
# the source code under the terms you reserve the author information.
#
# Author:
#     Dingding Technology, Inc.
#     Sunding Wei <swei(at)dingding.me>
#
# File: redmine/app/models/auth_source_imap.rb
#
require "net/imap"
require 'timeout'

#
# HOWTO
#
# 1. Execute the SQL
#    INSERT INTO auth_sources (type, name) values ("AuthSourceIMAP", "IMAP")
# 2. Change as you like
# 3. Redmine: set the user authentication mode to IMAP
# 4. Restart your web server
#

class AuthSourceIMAP < AuthSource

    def searchable?
        true
    end

    def authenticate(login, password)
        # IMAP server
        self.host = "{{ redmine_imap_auth_hostname }}"
        self.port = 143

        if(onthefly_register?)
            retVal = {
                :firstname => login.split('@')[0],
                :lastname => self.attr_lastname,
                :mail => login,
                :auth_source_id => self.id
            }
        else
            retVal = {
                :firstname => self.attr_firstname,
                :lastname => self.attr_lastname,
                :mail => self.attr_mail,
                :auth_source_id => self.id
            }
        end

        # add domain if username only
        suffix = "@{{ redmine_imap_auth_domain }}"
        if not login.end_with?(suffix)
            login += suffix
        end
        # authenticate
        begin
            logger.info "AuthSourceIMAP - #{login}: ************"
            imap = Net::IMAP.new(self.host, self.port)
            imap.authenticate('LOGIN', login, password)
        rescue Net::IMAP::NoResponseError => e
            retVal = nil
        end
        return retVal
    end

    def auth_method_name
        "IMAP"
    end
end

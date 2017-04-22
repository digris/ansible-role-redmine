Ansible Role for Redmine
========================


Requirements
------------

 - Debian 8.x
   + Debian < 8.x: We don't have any reasons to support older versions.
   + ubuntu: Should/could work as well, but has never been tested.

Role Variables
--------------

- `abcd`: abcd, defasults to `no`



Example Playbook
----------------

Minimal usage example:

    - hosts: redmine
      roles:
        - {
            role: digris.redmine,
          }




Post Install Steps
------------------

taken from: http://redmine-git-hosting.io/get_started/#step-9-finish-installation---configuration

You must set some additional settings :



 1. Enable Xitolite repositories in Administration -> Settings -> Repositories

 2. Configure plugin settings in Administration -> Redmine Git Hosting, specially :

   - SSH Keys path
   - Temp dir path (to store GitoliteAdmin repository)
   - LOCAL_CODE path (for Gitolite hooks) - Note: in web interface this is called "Gitolite non-core hooks directory"
   - Access urls (SSH, HTTP, HTTPS)
   - Hooks url (This url will be called by our Gitolite hook to trigger repository view refresh so be sure it’s callable)
   - Hooks install (This may overwrite your existing Gitolite hooks)

 3. Check your installation in Administration -> Redmine Git Hosting Config Checks tab.

 4. Set some permissions on Administration -> Roles page, particularly if you want users to be able to create SSH keys (see below).




License
-------

BSD

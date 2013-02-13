module Warden
  class SessionSerializer

    def key_for(scope)
      "warden.forumUser.#{scope}.key"
    end
  end
end

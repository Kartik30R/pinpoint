package com.nxquar.pinpoint.Model.Users;

import com.nxquar.pinpoint.constant.Role;

public interface AppUser {
    public String getEmail();
    public Role getRole();
    public String getPassword();
}

package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Users.Institute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface InstituteRepo extends JpaRepository<Institute, UUID> {
    Institute findByEmail(String email);

}

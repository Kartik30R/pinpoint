package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Model.Users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface InstituteRepo extends JpaRepository<Institute, UUID> {
    Institute findByEmail(String email);
    @Query("SELECT u FROM User u WHERE u.id = :userId AND u.institute.id = :instituteId")
    User findUserByIdAndInstituteId(@Param("userId") UUID userId, @Param("instituteId") UUID instituteId);

}

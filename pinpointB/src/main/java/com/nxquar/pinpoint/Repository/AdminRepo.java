package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Users.Admin;
import com.nxquar.pinpoint.Model.Users.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AdminRepo extends JpaRepository<Admin, UUID> {
    Admin findByEmail(String email);
    List<Admin> findByInstituteId(UUID instituteId);

    @Transactional
    @Modifying
    @Query("UPDATE Admin a SET a.institute = null WHERE a.institute.id = :instituteId")
    void updateInstituteToNullForAdmins(@Param("instituteId") UUID instituteId);

    @Query("SELECT u FROM User u WHERE u.admin.id = :adminId")
    List<User> findUsersByAdminId(@Param("adminId") UUID adminId);

    @Query("SELECT u FROM User u WHERE u.id = :userId AND u.admin.id = :adminId")
    User findUserByIdAndAdminId(@Param("userId") UUID userId, @Param("adminId") UUID adminId);

}

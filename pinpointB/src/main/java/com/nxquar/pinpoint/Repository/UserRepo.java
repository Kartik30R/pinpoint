package com.nxquar.pinpoint.Repository;

import com.nxquar.pinpoint.Model.Users.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepo extends JpaRepository<User, UUID> {
    User findByEmail(String email);
    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.institute = null WHERE u.institute.id = :instituteId")
    void updateInstituteToNullForUsers(@Param("instituteId") UUID instituteId);
    List<User> findByInstituteId(UUID instituteId);

}

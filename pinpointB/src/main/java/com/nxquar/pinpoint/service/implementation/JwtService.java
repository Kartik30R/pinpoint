package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.Model.Users.AppUser;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.function.Function;

@Service
public class JwtService {

    public String generateToken(AppUser user) {
        HashMap<String, Object> claims = new HashMap<>();
        return Jwts.builder()
                .claims()
                .add(claims)
                .and()
                .subject(user.getEmail()) // ✅ Use email instead of name
                .issuer("DCB")
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10)) // 10 hours
                .signWith(generateKey())
                .compact();
    }

    private SecretKey generateKey() {
        byte[] decode = Decoders.BASE64.decode(getSecretKey());
        return Keys.hmacShaKeyFor(decode);
    }

    private String getSecretKey() {
        return "20eb7d120fa3fd2344a5529d4c79a3578c76a6351e210426fbbc5ce9fc6106753e82773ed71e9b0ff844945dca29181e8e86790da77512b7c63bd48c8d27f7bcd127d593ed2bc93876df45dfacaa40d1e92e1c461107073416e06f829bde95b103236451d883768cbe09aa40287e334edabb0f7eb17eedac671d6dab0d9e3df93f4510b977209c039c3a9a40efe9e703b386f7a38d6006b5b05858758ff66027a13adfb71f73c79a0f5d7146517a2e0c1189443397e0b209e8350d68990b9b7ad163264715f6a1bc49a6ca508e547be91f8e3d488917d4ad7972c595535939e3e40e02e4844fd1e66cddbf21c64dc2dbdac127edb995d62f4a8ab523172b4cf8"; // Replace this with env variable or config
    }

    public String extractUserName(String token) {
        return getClaims(token, Claims::getSubject);
    }

    private <T> T getClaims(String token, Function<Claims, T> claimsResolver) {
        Claims claims = extractClaims(token);
        return claimsResolver.apply(claims);
    }

    private Claims extractClaims(String token) {
        return Jwts.parser()
                .verifyWith(generateKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public boolean isTokenValid(String token, UserDetails userDetails) {
        final String userName = extractUserName(token);
        return userName.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }

    private boolean isTokenExpired(String token) {
        return getClaims(token, Claims::getExpiration).before(new Date());
    }
}

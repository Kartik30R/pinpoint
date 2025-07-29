package com.nxquar.pinpoint.controller;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Address;
import com.nxquar.pinpoint.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/addresses")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @PostMapping("/{instituteId}")
    public ResponseEntity<Address> createAddress(@PathVariable UUID instituteId,
                                                 @RequestBody Address address) {
        return ResponseEntity.ok(addressService.createAddress(address, instituteId));
    }

    @GetMapping("/{instituteId}")
    public ResponseEntity<Address> getAddress(@PathVariable UUID instituteId) {
        return ResponseEntity.ok(addressService.getAddresses(instituteId));
    }

    @PutMapping
    public ResponseEntity<MessageResponse> updateAddress(@RequestBody Address address) {
        return ResponseEntity.ok(addressService.updateAddress(address));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<MessageResponse> deleteAddress(@PathVariable UUID id) {
        return ResponseEntity.ok(addressService.deleteAddress(id));
    }
}

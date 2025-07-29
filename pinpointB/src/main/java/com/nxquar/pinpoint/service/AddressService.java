package com.nxquar.pinpoint.service;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Address;

import java.util.List;
import java.util.UUID;

public interface AddressService {
    Address createAddress (Address address,UUID instituteId);
    Address getAddresses(UUID instituteId);
    MessageResponse updateAddress(Address address);
    MessageResponse deleteAddress(UUID id);
}

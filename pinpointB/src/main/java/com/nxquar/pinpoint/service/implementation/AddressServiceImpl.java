package com.nxquar.pinpoint.service.implementation;

import com.nxquar.pinpoint.DTO.MessageResponse;
import com.nxquar.pinpoint.Model.Address;
import com.nxquar.pinpoint.Model.Users.Institute;
import com.nxquar.pinpoint.Repository.AddressRepo;
import com.nxquar.pinpoint.Repository.InstituteRepo;
import com.nxquar.pinpoint.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressRepo addressRepository;

    @Autowired
    private InstituteRepo instituteRepo;

    @Override
    public Address createAddress(Address address, UUID instituteId) {
        Optional<Institute> optionalInstitute = instituteRepo.findById(instituteId);
        if (optionalInstitute.isPresent()) {
            Address saved = addressRepository.save(address);
            Institute institute = optionalInstitute.get();
            institute.setAddress(saved);
            instituteRepo.save(institute);
            return saved;
        }
        throw new RuntimeException("Institute not found with id: " + instituteId);
    }

    @Override
    public Address getAddresses(UUID instituteId) {
        return instituteRepo.findById(instituteId)
                .map(Institute::getAddress)
                .orElse(null);
    }


    @Override
    public MessageResponse updateAddress(Address address) {
        Optional<Address> existing = addressRepository.findById(address.getId());
        if (existing.isPresent()) {
            Address addr = existing.get();
            addr.setStreetAddress(address.getStreetAddress());
            addr.setCity(address.getCity());
            addr.setState(address.getState());
            addr.setPostalCode(address.getPostalCode());
            addr.setCountry(address.getCountry());
            addressRepository.save(addr);
            return new MessageResponse("Address updated successfully");
        }
        return new MessageResponse("Address not found");
    }

    @Override
    public MessageResponse deleteAddress(UUID id) {
        if (addressRepository.existsById(id)) {
            addressRepository.deleteById(id);
            return new MessageResponse("Address deleted");
        }
        return new MessageResponse("Address not found");
    }
}

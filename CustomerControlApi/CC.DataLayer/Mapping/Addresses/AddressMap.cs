using System;
using AutoMapper;
using CC.DataLayer.InputModels.InputAddresses;
using CC.DataLayer.Models.Addresses;
using CC.DataLayer.ViewModels.AddressViewModels;

namespace CC.DataLayer.Mapping.Addresses
{
    public class AddressMap: Profile
    {
        public AddressMap()
        {
            CreateMap<Address, AddressViewModel>().ReverseMap();
            CreateMap<Address, InputAddress>().ReverseMap();
            CreateMap<AddressViewModel, InputAddress>().ReverseMap();
        }
    }
}

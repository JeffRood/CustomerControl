using System;
using AutoMapper;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.Models.Persons;
using CC.DataLayer.ViewModels.PersonViewModels;

namespace CC.DataLayer.Mapping.Persons
{
    public class PersonMap: Profile
    {
        public PersonMap()
        {
            CreateMap<Person, PersonViewModel>().ReverseMap();
            CreateMap<Person, InputPerson>().ReverseMap();
            CreateMap<PersonViewModel, InputPerson>().ReverseMap();

        }

    }
}

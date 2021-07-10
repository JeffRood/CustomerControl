using System;
using AutoMapper;
using CC.BusinessLayer.Interfaces.Persons;
using CC.BusinessLayer.Repository.Base;
using CC.DataLayer.Context;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.Models.Persons;
using CC.DataLayer.ViewModels.PersonViewModels;

namespace CC.BusinessLayer.Repository.Persons
{
    public sealed class PersonRepository : BaseRespository<InputPerson, PersonViewModel, Person>, IPersonRepository
    {
        private readonly CC_Context _CcContext;

        public PersonRepository(CC_Context CcContext, IMapper mapper) : base(CcContext, mapper)
      => _CcContext = CcContext;
    }
}

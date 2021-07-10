using System;
using CC.BusinessLayer.Interfaces.Repository;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.Models.Persons;
using CC.DataLayer.ViewModels.PersonViewModels;

namespace CC.BusinessLayer.Interfaces.Persons
{
    public interface IPersonRepository : IRepository<InputPerson, PersonViewModel, Person>
    { }
}

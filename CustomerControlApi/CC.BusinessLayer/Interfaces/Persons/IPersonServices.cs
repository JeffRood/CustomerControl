using System;
using System.Collections.Generic;
using CC.BusinessLayer.Interfaces.IResultOperation;
using CC.BusinessLayer.Interfaces.Service;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.Models.Persons;
using CC.DataLayer.ViewModels.PersonViewModels;

namespace CC.BusinessLayer.Interfaces.Persons
{
    public interface IPersonServices: IService<InputPerson, PersonViewModel, Person>
    { }
}

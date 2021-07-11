using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using CC.BusinessLayer.Helper;
using CC.BusinessLayer.Interfaces.IResultOperation;
using CC.BusinessLayer.Interfaces.Persons;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.Models.Persons;
using CC.DataLayer.ViewModels.PersonViewModels;

namespace CC.BusinessLayer.Services.Persons
{
    public sealed class PersonServices: IPersonServices
    {
        private readonly IPersonRepository _PersonDB;
        public PersonServices(IPersonRepository person) 
        {
            _PersonDB = person;
        }

        public async Task<IResultOperation<PersonViewModel>> Create(InputPerson entity)
        {

            IResultOperation<PersonViewModel> result =  await _PersonDB.CreateAsync(entity, "");
            if (result == null)
            {
                return ResultOperation<PersonViewModel>.Fail(result.Message);
            }
            return result;

        }

        public async Task<IEnumerable<PersonViewModel>> GetAll()
        => await _PersonDB.GetAllAsync();
            
        

        public Task<IResultOperation<PersonViewModel>> Remove(int Id)
        {
            throw new NotImplementedException();
        }

        public Task<IResultOperation<PersonViewModel>> Update(Person entity)
        {
            throw new NotImplementedException();
        }
    }
}

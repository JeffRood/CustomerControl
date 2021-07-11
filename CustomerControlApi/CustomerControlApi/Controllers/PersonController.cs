using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CC.BusinessLayer.Interfaces.IResultOperation;
using CC.BusinessLayer.Interfaces.Persons;
using CC.DataLayer.InputModels.InputPersons;
using CC.DataLayer.ViewModels.PersonViewModels;
using Microsoft.AspNetCore.Mvc;

namespace CustomerControlApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PersonController:ControllerBase
    {
        private readonly IPersonServices _PersonServices;
       public PersonController(IPersonServices personServices)
        {
            _PersonServices = personServices;
        }


        [HttpGet]
        public async Task<IEnumerable<PersonViewModel>> Get()
        => await _PersonServices.GetAll();

        [HttpPost]
        public Task<IResultOperation<PersonViewModel>> Post(InputPerson person)
        => _PersonServices.Create(person);
    
    }
}

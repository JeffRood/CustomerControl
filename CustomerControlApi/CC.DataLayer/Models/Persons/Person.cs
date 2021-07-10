using System;
using System.Collections.Generic;
using CC.DataLayer.Models.Addresses;
using CC.DataLayer.Models.Core;
namespace CC.DataLayer.Models.Persons
{
    public class Person: BaseModel
    {

        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string FirstLastName { get; set; }
        public string SecondLastName { get; set; }
        public string Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public string PhoneNumber { get; set; }
        public string DocumentNumber { get; set; }
        public virtual List<Address> Addresses { get; set; }

    }
}

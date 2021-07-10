using System;
using System.Collections.Generic;
using CC.DataLayer.InputModels.InputAddresses;

namespace CC.DataLayer.InputModels.InputPersons
{
    public class InputPerson
    {
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string FirstLastName { get; set; }
        public string SecondLastName { get; set; }
        public string Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public string PhoneNumber { get; set; }
        public string DocumentNumber { get; set; }
        public virtual List<InputAddress> Addresses { get; set; }
    }
}

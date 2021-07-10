using System;
using System.Collections.Generic;
using CC.DataLayer.ViewModels.AddressViewModels;

namespace CC.DataLayer.ViewModels.PersonViewModels
{
    public class PersonViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string FirstLastName { get; set; }
        public string SecondLastName { get; set; }
        public string Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public string PhoneNumber { get; set; }
        public string DocumentNumber { get; set; }
        public virtual List<AddressViewModel> Addresses { get; set; }
    }
}

using System;
using CC.DataLayer.Models.Core;
using CC.DataLayer.Models.Persons;

namespace CC.DataLayer.Models.Addresses
{
    public class Address: BaseModel
    {
        public string Description { get; set; }
        public int PersonId { get; set; }
        public virtual Person Person { get; set; }
    }
}

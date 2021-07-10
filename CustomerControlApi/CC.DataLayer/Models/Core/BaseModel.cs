using System;
using System.ComponentModel.DataAnnotations;

namespace CC.DataLayer.Models.Core
{
    public class BaseModel
    {
         [Key]
         public int Id { get; set; }
    }
}
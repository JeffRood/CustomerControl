using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using CC.BusinessLayer.Interfaces.IResultOperation;

namespace CC.BusinessLayer.Interfaces.Service
{
    public interface IService<InputT, ViewT, T>
    {
        Task<IResultOperation<ViewT>> Create(InputT entity);
        Task<IEnumerable<ViewT>> GetAll();
        Task<IResultOperation<ViewT>> Remove(int Id);
        Task<IResultOperation<ViewT>> Update(T entity);
    }
}

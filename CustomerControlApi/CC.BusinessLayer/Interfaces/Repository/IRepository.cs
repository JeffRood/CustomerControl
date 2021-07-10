using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using CC.BusinessLayer.Interfaces.IResultOperation;

namespace CC.BusinessLayer.Interfaces.Repository
{
    public interface IRepository<T>
    {
        IResultOperation<T> Create(T entity);

        IEnumerable<T> FindAll(Expression<Func<T, bool>> predicate);

        T Find(Expression<Func<T, bool>> predicate, params Expression<Func<T, object>>[] includes);

        void Save();

        IResultOperation<T> Update(T entity, string Mensaje);

        IEnumerable<T> Get();
    }
}

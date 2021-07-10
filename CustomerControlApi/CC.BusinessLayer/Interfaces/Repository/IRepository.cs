using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using CC.BusinessLayer.Interfaces.IResultOperation;

namespace CC.BusinessLayer.Interfaces.Repository
{
    public interface IRepository<TInput,TView,TEntity>
    {
        Task<IResultOperation<TView>> CreateAsync(TInput entity, string Mensaje);
        TEntity Find(Expression<Func<TEntity, bool>> predicate, params Expression<Func<TEntity, object>>[] includes);
        void Save();
        IEnumerable<TEntity> Get();
        IEnumerable<TEntity> FindAll(Expression<Func<TEntity, bool>> predicate);
        IResultOperation<TView> Update(TEntity entity, string Mensaje);
        IResultOperation<TEntity> Create(TEntity entity);
    }
}

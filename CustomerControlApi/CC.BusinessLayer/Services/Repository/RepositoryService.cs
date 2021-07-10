using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using CC.BusinessLayer.Interfaces.IResultOperation;
using CC.BusinessLayer.Interfaces.Repository;
using CC.BusinessLayer.Helper;
using CC.DataLayer.Context;
using Microsoft.EntityFrameworkCore;

namespace CC.BusinessLayer.Services.Repository
{
    public class RepositoryService<T> : IRepository<T> where T : class
    {
        private CC_Context _context;
        private readonly DbSet<T> _set;

        public RepositoryService(CC_Context DbContext)
        {
            _context = DbContext;
            _set = DbContext.Set<T>();
        }

        public IResultOperation<T> Create(T entity)
        {
            _context.Add(entity);
            _context.SaveChanges();
            return ResultOperation<T>.Ok(entity);
        }

        public T Find(Expression<Func<T, bool>> predicate, params Expression<Func<T, object>>[] includes)
        {
            IQueryable<T> queryable = _set.AsQueryable();

            foreach (Expression<Func<T, object>> include in includes)
            {
                queryable = queryable.Include(include);
            }

            return queryable.FirstOrDefault(predicate);
        }

        public IEnumerable<T> FindAll(Expression<Func<T, bool>> predicate)
        => _set.Where(predicate).ToList();

        public IEnumerable<T> Get()
        => _set.AsEnumerable();


        public void Save()
         => _context.SaveChanges();

        public IResultOperation<T> Update(T entity, string Mensaje)
        {
            _context.Update(entity);
            _context.SaveChanges();
            return ResultOperation<T>.Ok(Mensaje);
        }

    }
}

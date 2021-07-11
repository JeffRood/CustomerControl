using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using CC.BusinessLayer.Helper;
using CC.BusinessLayer.Interfaces.IResultOperation;
using CC.BusinessLayer.Interfaces.Repository;
using CC.DataLayer.Context;
using Microsoft.EntityFrameworkCore;
using AutoMapper;

namespace CC.BusinessLayer.Repository.Base
{
    public class BaseRespository<TInput, TView, TEntity> : IRepository<TInput, TView, TEntity> where TEntity : class
    {
        private readonly IMapper _mapper;

        private CC_Context _context;
        private readonly DbSet<TEntity> _set;

        public BaseRespository(CC_Context DbContext, IMapper mapper)
        {
            _mapper = mapper;

            _context = DbContext;
            _set = DbContext.Set<TEntity>();
        }

        public IResultOperation<TEntity> Create(TEntity entity)
        {
            _context.Add(entity);
            _context.SaveChanges();
            return ResultOperation<TEntity>.Ok(entity);
        }

        public TEntity Find(Expression<Func<TEntity, bool>> predicate, params Expression<Func<TEntity, object>>[] includes)
        {
            IQueryable<TEntity> queryable = _set.AsQueryable();

            foreach (Expression<Func<TEntity, object>> include in includes)
            {
                queryable = queryable.Include(include);
            }

            return queryable.FirstOrDefault(predicate);
        }

        public IEnumerable<TEntity> FindAll(Expression<Func<TEntity, bool>> predicate)
        => _set.Where(predicate).ToList();

        public async Task<IEnumerable<TView>> GetAllAsync() {

            var result = await _set.ToListAsync();
            return _mapper.Map<List<TView>>(result);

        }
        public IEnumerable<TView> Get()
        {

            var listData = _set.AsEnumerable();
            return _mapper.Map<List<TView>>(listData);

        }


        public void Save()
         => _context.SaveChanges();

        public IResultOperation<TView> Update(TEntity entity, string Mensaje)
        {
            _context.Update(entity);
            _context.SaveChanges();
            return ResultOperation<TView>.Ok(Mensaje);
        }

        public async Task<IResultOperation<TView>> CreateAsync(TInput entity, string Mensaje)
        {

            var mapPerson = _mapper.Map<TEntity>(entity);
            var DataAdded =  await _set.AddAsync(mapPerson);
            Save();
            return ResultOperation<TView>.Ok(Mensaje);
        }
    }
}
        

 
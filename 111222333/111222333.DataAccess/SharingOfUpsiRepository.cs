using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using 111222333.DTO;

namespace 111222333
{
    public class SharingOfUpsiRepository : ISharingOfUpsiRepository
    {
        private readonly ICollection<SharingOfUpsiModel> _sharingOfUpsi;

        public SharingOfUpsiRepository()
        {
            _sharingOfUpsi = new List<SharingOfUpsiModel>();
        }

        public async Task<ICollection<SharingOfUpsiModel>> GetAllAsync()
        {
            return await Task.FromResult(_sharingOfUpsi);
        }

        public async Task<SharingOfUpsiModel> GetByIdAsync(int id)
        {
            return await Task.FromResult(_sharingOfUpsi.FirstOrDefault(x => x.Id == id));
        }

        public async Task<SharingOfUpsiModel> CreateAsync(SharingOfUpsiModel model)
        {
            _sharingOfUpsi.Add(model);
            return await Task.FromResult(model);
        }

        public async Task<SharingOfUpsiModel> UpdateAsync(SharingOfUpsiModel model)
        {
            var entity = _sharingOfUpsi.FirstOrDefault(x => x.Id == model.Id);
            if (entity == null)
            {
                return null;
            }

            entity.UpsiType = model.UpsiType;
            entity.UpsiOwner = model.UpsiOwner;
            entity.UpsiDescription = model.UpsiDescription;

            return await Task.FromResult(entity);
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var entity = _sharingOfUpsi.FirstOrDefault(x => x.Id == id);
            if (entity == null)
            {
                return false;
            }

            _sharingOfUpsi.Remove(entity);

            return await Task.FromResult(true);
        }
    }
}